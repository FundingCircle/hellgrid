require 'spec_helper'

describe Hellgrid::Project do
  subject(:project) { described_class.new(project_path) }

  let(:project_path) { 'spec/tmp/foo/' }
  let(:lockfile_path) { File.join project_path, 'Gemfile.lock' }

  before do
    delete_tmp_folder

    create_file lockfile_path, <<-FOO_GEMFILE
GEM
  remote: https://rubygems.org/
  specs:
    diff-lcs (1.2.5)
    rake (11.1.0)
    rspec (3.0.0)
      rspec-core (~> 3.0.0)
      rspec-expectations (~> 3.0.0)
      rspec-mocks (~> 3.0.0)
    rspec-core (3.0.4)
      rspec-support (~> 3.0.0)
    rspec-expectations (3.0.4)
      diff-lcs (>= 1.2.0, < 2.0)
      rspec-support (~> 3.0.0)
    rspec-mocks (3.0.4)
      rspec-support (~> 3.0.0)
    rspec-support (3.0.4)

PLATFORMS
  ruby

DEPENDENCIES
  rake (= 11.1.0)
  rspec (= 3.0.0)

FOO_GEMFILE
  end

  describe '#dependency_matrix' do
    it 'is a Hash' do
      expect(subject.dependency_matrix).to be_a(Hash)
    end

    it 'returns dependencies' do
      expected_result = {
        'diff-lcs'           => '1.2.5',
        'rake'               => '11.1.0',
        'rspec'              => '3.0.0',
        'rspec-core'         => '3.0.4',
        'rspec-expectations' => '3.0.4',
        'rspec-mocks'        => '3.0.4',
        'rspec-support'      => '3.0.4'
      }

      expect(subject.dependency_matrix).to eq(expected_result)
    end
  end
end
