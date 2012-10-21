require 'spec_helper'

unit_spec do
  object_args { [field, context] }

  let(:field)   { mock('Field',   :name => :field_name)  }
  let(:context) { mock('Context', :html_id => 'example') }

  before do
    context.stub(:html_name).with(:field_name).and_return('example[field_name]')
    context.stub(:selected?).with(:field_name).and_return(is_true)
  end

  context 'when domain_value is false' do
    let(:is_true) { false }

    it 'should produce correct html' do
      split_html(subject.to_s).should eql(compress(<<-HTML))
        <input type="hidden" name="example[field_name]" value="0"/>
        <input id="example_field_name" type="checkbox" name="example[field_name]" value="1" checked=""/>
      HTML
    end

    idempotent_method
  end

  context 'when domain_value is true' do
    let(:is_true) { true }

    it 'should produce correct html' do
      split_html(subject.to_s).should eql(compress(<<-HTML))
        <input type="hidden" name="example[field_name]" value="0"/>
        <input id="example_field_name" type="checkbox" name="example[field_name]" value="1" checked="checked"/>
      HTML
    end

    idempotent_method
  end
end
