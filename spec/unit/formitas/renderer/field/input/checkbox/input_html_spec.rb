require 'spec_helper'

unit_spec do
  object_args { [field, context] }

  let(:field)   { mock('Field',   :name => :field_name)      }
  let(:context) { mock('Context', :html_id => 'example')     }

  let(:class_under_test) do
    is_selected = self.is_selected
    Class.new(described_class) do
      define_method(:selected?) do
        is_selected
      end

      define_method(:html_value) { 'some_value' }
    end
  end

  before do
    context.stub(:html_name).with(:field_name).and_return('example[field_name]')
  end

  context 'when selected? is false' do
    let(:is_selected) { false }

    it 'should produce correct html' do
      split_html(subject.to_s).should eql(compress(<<-HTML))
        <input id="example_field_name" type="checkbox" name="example[field_name]" value="some_value"/>
      HTML
    end

    idempotent_method
  end

  context 'when selected? is true' do
    let(:is_selected) { true }

    it 'should produce correct html' do
      split_html(subject.to_s).should eql(compress(<<-HTML))
        <input id="example_field_name" type="checkbox" name="example[field_name]" value="some_value" checked="checked"/>
      HTML
    end

    idempotent_method
  end
end
