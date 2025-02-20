# frozen_string_literal: true

require 'spec_helper'

describe Hellgrid::Matrix do
  subject(:matrix) { described_class.new }

  def stub_project(name: 'foo', dependency_matrix: {})
    instance_double(Hellgrid::Project, name:, dependency_matrix:)
  end

  describe '#add_project' do
    it 'adds a project' do
      expect do
        matrix.add_project(stub_project)
      end.to change { matrix.projects.count }.by(1)
    end
  end

  describe '#project_names' do
    it 'returns project names' do
      matrix.add_project(stub_project(name: 'foo'))
      matrix.add_project(stub_project(name: 'bar'))

      expect(matrix.project_names).to eq(%w[bar foo])
    end
  end

  describe '#gem_names' do
    it 'returns gem names' do
      matrix.add_project(
        stub_project(
          dependency_matrix: {
            'a' => '1.0.1',
            'b' => '2.0.1',
            'c' => '3.0.1'
          }
        )
      )

      matrix.add_project(
        stub_project(
          dependency_matrix: {
            'b' => '2.0.2',
            'c' => '3.0.2',
            'd' => '4.0.2'
          }
        )
      )

      expect(matrix.gem_names).to eq(%w[a b c d])
    end
  end

  describe '#gems_by_usage' do
    before do
      matrix.add_project(
        stub_project(
          dependency_matrix: {
            'a' => '1.0.1',
            'b' => '2.0.1',
            'c' => '3.0.1'
          }
        )
      )

      matrix.add_project(
        stub_project(
          dependency_matrix: {
            'b' => '2.0.2',
            'c' => '3.0.2',
            'd' => '4.0.2'
          }
        )
      )
    end

    it 'returns an array' do
      expect(matrix.gems_by_usage).to be_a(Hash)
    end

    it 'returns ordered' do
      expected_result = {
        'b' => 2,
        'c' => 2,
        'a' => 1,
        'd' => 1
      }

      expect(matrix.gems_by_usage).to eq(expected_result)
    end
  end

  describe '#projects_sorted_by_name' do
    let(:project_a) { stub_project(name: 'a') }
    let(:project_b) { stub_project(name: 'b') }
    let(:project_c) { stub_project(name: 'c') }

    before do
      matrix.add_project(project_b)
      matrix.add_project(project_c)
      matrix.add_project(project_a)
    end

    it 'sorted by name projects' do
      expected_result = [project_a, project_b, project_c].map(&:name)

      expect(matrix.projects_sorted_by_name.map(&:name)).to eq(expected_result)
    end
  end

  describe '#sorted_by_most_used' do
    before do
      matrix.add_project(
        stub_project(
          name: 'foo',
          dependency_matrix: {
            'a' => '1.0.1',
            'b' => '2.0.1',
            'c' => '3.0.1'
          }
        )
      )

      matrix.add_project(
        stub_project(
          name: 'bar',
          dependency_matrix: {
            'b' => '2.0.2',
            'c' => '3.0.2',
            'd' => '4.0.2'
          }
        )
      )
    end

    it 'returns matrix' do
      expected_result = [
        [nil, 'bar', 'foo'],
        ['b', '2.0.2', '2.0.1'],
        ['c', '3.0.2', '3.0.1'],
        ['a', nil, '1.0.1'],
        ['d', '4.0.2', nil]
      ]

      expect(matrix.sorted_by_most_used).to eq(expected_result)
    end
  end
end
