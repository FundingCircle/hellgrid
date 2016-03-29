require 'spec_helper'

describe 'bin/bundler_dependency_matrix' do
  before do
    delete_tmp_folder

    create_file 'spec/tmp/foo/Gemfile.lock', <<-FOO_GEMFILE
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

    create_file 'spec/tmp/bar/Gemfile.lock', <<-BAR_GEMFILE
GEM
  remote: https://rubygems.org/
  specs:
    diff-lcs (1.2.5)
    rake (10.0.0)
    rspec (2.0.0)
      rspec-core (= 2.0.0)
      rspec-expectations (= 2.0.0)
      rspec-mocks (= 2.0.0)
    rspec-core (2.0.0)
    rspec-expectations (2.0.0)
      diff-lcs (>= 1.1.2)
    rspec-mocks (2.0.0)
      rspec-core (= 2.0.0)
      rspec-expectations (= 2.0.0)

PLATFORMS
  ruby

DEPENDENCIES
  rake (= 10.0.0)
  rspec (= 2.0.0)

BAR_GEMFILE
  end

  it 'returns bundler dependency matrix' do
    expected_result = <<-TABLE
         x          |  bar   |  foo   
--------------------+--------+--------
      diff-lcs      | 1.2.5  | 1.2.5  
        rake        | 10.0.0 | 11.1.0 
       rspec        | 2.0.0  | 3.0.0  
     rspec-core     | 2.0.0  | 3.0.4  
 rspec-expectations | 2.0.0  | 3.0.4  
    rspec-mocks     | 2.0.0  | 3.0.4  
   rspec-support    |   x    | 3.0.4  
TABLE

    expect(`#{PROJECT_ROOT}/bin/bundler_dependency_matrix #{PROJECT_ROOT}/spec/tmp`).to eq(expected_result)
  end
end
