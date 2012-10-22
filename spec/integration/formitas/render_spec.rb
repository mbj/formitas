require 'spec_helper'
require 'virtus'

describe Formitas, 'rendering' do
  subject { renderer.render }

  let(:renderer) { Formitas::Renderer::Context::Form.new(form) }
  
  let(:empty_form) do
    Formitas::Form.new(
      :context   => empty_context,
      :method    => 'post',
      :enctype   => 'www-form-urlencoded',
      :action    => '/some/target'
    )
  end

  let(:invalid_resource) do
    model.new(:name => 'Markus Schirp')
  end

  let(:valid_resource) do
    model.new(
      :membership => membership_a,
      :surname => 'Mr', 
      :name => 'Markus Schirp', 
      :terms_of_service => true,
      :text => 'Foo'
    )
  end

  let(:validator) do
    Class.new do
      include Aequitas::Validator
      validates_presence_of :membership
      validates_presence_of :surname
      validates_presence_of :name
      validates_presence_of :text
      validates_acceptance_of :terms_of_service
    end
  end


  let(:empty_context) do
    Formitas::Context::Empty.new(
      :name      => :person,
      :validator => validator,
      :fields    => Formitas::FieldSet.new(fields)
    )
  end

  let(:membership_a) do 
    Class.new do 
      def self.name; 'Membership-A'; end
    end
  end

  let(:membership_b) do 
    Class.new do 
      def self.name; 'Membership-B'; end 
    end
  end

  let(:model) do
    Class.new do
      include Virtus
      attribute :membership,        Object
      attribute :surname,           String
      attribute :name,              String
      attribute :text,              String
      attribute :terms_of_service,  Virtus::Attribute::Boolean
    end
  end

  let(:fields) do
    [
      Formitas::Field::Select::Single.build(
        :membership,
        :collection => Formitas::Collection::Mapper.new(
          :mapping => {
            'membership-a' => membership_a,
            'membership-b' => membership_b
          },
          :label_renderer => Formitas::Renderer::Label::Block.new { |object| object.domain_value.name.upcase }
        )
      ),
      Formitas::Field::Select::Single.build(
        :surname, 
        :collection => Formitas::Collection::String.new(
          :strings => %w(Mr Mrs)
        )
      ),
      Formitas::Field::String.build(:name),
      Formitas::Field::Boolean.build(:terms_of_service),
      Formitas::Field::String.build(:text, :renderer => Formitas::Renderer::Field::Textarea)
    ]
  end

  context 'with empty form' do
    let(:form) { empty_form }

    it 'should render expected html' do
      subject.to_s.split('><').join(">\n<").should eql(compress(<<-HTML))
        <form action="/some/target" method="post" enctype="www-form-urlencoded">
          <div class="input">
            <label for="person_membership">Membership</label>
            <select id="person_membership" name="person[membership]">
              <option value="membership-a">MEMBERSHIP-A</option>
              <option value="membership-b">MEMBERSHIP-B</option>
            </select>
          </div>
          <div class="input">
            <label for="person_surname">Surname</label>
            <select id="person_surname" name="person[surname]">
              <option value="Mr">Mr</option>
              <option value="Mrs">Mrs</option>
            </select>
          </div>
          <div class="input">
            <label for="person_name">Name</label>
            <input id="person_name" type="text" name="person[name]" value=""/>
          </div>
          <div class="input">
            <label for="person_terms_of_service">Terms of service</label>
            <input type="hidden" name="person[terms_of_service]" value="0"/>
            <input id="person_terms_of_service" type="checkbox" name="person[terms_of_service]" value="1" checked=""/>
          </div>
          <div class="input">
            <label for="person_text">Text</label>
            <textarea id="person_text" name="person[text]">
            </textarea>
          </div>
        </form>
      HTML
    end

  end

  context 'with valid resource' do

    let(:form) { empty_form.with_resource(valid_resource) }

    it 'should render expected html' do
      subject.to_s.split('><').join(">\n<").should eql(compress(<<-HTML))
        <form action="/some/target" method="post" enctype="www-form-urlencoded">
          <div class="input">
            <label for="person_membership">Membership</label>
            <select id="person_membership" name="person[membership]">
              <option value="membership-a" selected="selected">MEMBERSHIP-A</option>
              <option value="membership-b">MEMBERSHIP-B</option>
            </select>
          </div>
          <div class="input">
            <label for="person_surname">Surname</label>
            <select id="person_surname" name="person[surname]">
              <option value="Mr" selected="selected">Mr</option>
              <option value="Mrs">Mrs</option>
            </select>
          </div>
          <div class="input">
            <label for="person_name">Name</label>
            <input id="person_name" type="text" name="person[name]" value="Markus Schirp"/>
          </div>
          <div class="input">
            <label for="person_terms_of_service">Terms of service</label>
            <input type="hidden" name="person[terms_of_service]" value="0"/>
            <input id="person_terms_of_service" type="checkbox" name="person[terms_of_service]" value="1" checked="checked"/>
          </div>
          <div class="input">
            <label for="person_text">Text</label>
            <textarea id="person_text" name="person[text]">Foo</textarea>
          </div>
        </form>
      HTML
    end
  end

  context 'with resource and errors' do

    it 'should yield on error' do
      yields = []
      form.renderer.on_error { yields << :yield }

      yields.should eql([:yield])
    end

    let(:form) { empty_form.with_resource(invalid_resource) }

    it 'should render expected html' do
      subject.to_s.split('><').join(">\n<").should eql(compress(<<-HTML))
        <form action="/some/target" method="post" enctype="www-form-urlencoded">
          <div class="input error">
            <label for="person_membership">Membership</label>
            <select id="person_membership" name="person[membership]">
              <option value="membership-a">MEMBERSHIP-A</option>
              <option value="membership-b">MEMBERSHIP-B</option>
            </select>
            <div class="error-messages">
              <ul>
                <li class="error-message">Membership: Blank</li>
              </ul>
            </div>
          </div>
          <div class="input error">
            <label for="person_surname">Surname</label>
            <select id="person_surname" name="person[surname]">
              <option value="Mr">Mr</option>
              <option value="Mrs">Mrs</option>
            </select>
            <div class="error-messages">
              <ul>
                <li class="error-message">Surname: Blank</li>
              </ul>
            </div>
          </div>
          <div class="input">
            <label for="person_name">Name</label>
            <input id="person_name" type="text" name="person[name]" value="Markus Schirp"/>
          </div>
          <div class="input">
            <label for="person_terms_of_service">Terms of service</label>
            <input type="hidden" name="person[terms_of_service]" value="0"/>
            <input id="person_terms_of_service" type="checkbox" name="person[terms_of_service]" value="1" checked=""/>
          </div>
          <div class="input error">
            <label for="person_text">Text</label>
            <textarea id="person_text" name="person[text]">
            </textarea>
            <div class="error-messages">
              <ul>
                <li class="error-message">Text: Blank</li>
              </ul>
            </div>
          </div>
        </form>
      HTML
    end

  end
end
