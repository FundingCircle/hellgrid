require 'spec_helper'

describe 'bin/hellgrid' do
  before do
    delete_tmp_folder

    create_file 'spec/tmp/in/foo/Gemfile.lock', <<~FOO_GEMFILE
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

    create_file 'spec/tmp/bar/Gemfile.lock',  <<~BAR_GEMFILE
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

  it 'returns a matrix with the versions of all used gems' do
    expected_result = <<~TABLE
                                 x          |  bar   | in/foo 
                        --------------------+--------+--------
                              diff-lcs      | 1.2.5  | 1.2.5  
                                rake        | 10.0.0 | 11.1.0 
                               rspec        | 2.0.0  | 3.0.0  
                             rspec-core     | 2.0.0  | 3.0.4  
                         rspec-expectations | 2.0.0  | 3.0.4  
                            rspec-mocks     | 2.0.0  | 3.0.4  
                           rspec-support    |   x    | 3.0.4  
                      TABLE

    expect(`#{PROJECT_ROOT}/bin/hellgrid #{PROJECT_ROOT}/spec/tmp`).to eq(expected_result)
  end

  it 'could be run from random directory' do
    expected_result = <<~TABLE
                                 x          |  bar   | in/foo 
                        --------------------+--------+--------
                              diff-lcs      | 1.2.5  | 1.2.5  
                                rake        | 10.0.0 | 11.1.0 
                               rspec        | 2.0.0  | 3.0.0  
                             rspec-core     | 2.0.0  | 3.0.4  
                         rspec-expectations | 2.0.0  | 3.0.4  
                            rspec-mocks     | 2.0.0  | 3.0.4  
                           rspec-support    |   x    | 3.0.4  
                      TABLE

    Bundler.with_clean_env do
      expect(`cd ~ && #{PROJECT_ROOT}/bin/hellgrid #{PROJECT_ROOT}/spec/tmp`).to eq(expected_result)
    end
  end

  it 'uses the current working directory by default' do
    expected_result = <<~TABLE
                                 x          |  bar   | in/foo 
                        --------------------+--------+--------
                              diff-lcs      | 1.2.5  | 1.2.5  
                                rake        | 10.0.0 | 11.1.0 
                               rspec        | 2.0.0  | 3.0.0  
                             rspec-core     | 2.0.0  | 3.0.4  
                         rspec-expectations | 2.0.0  | 3.0.4  
                            rspec-mocks     | 2.0.0  | 3.0.4  
                           rspec-support    |   x    | 3.0.4  
                      TABLE

    Bundler.with_clean_env do
      expect(`cd #{PROJECT_ROOT}/spec/tmp && #{PROJECT_ROOT}/bin/hellgrid`).to eq(expected_result)
    end
  end

  it 'searches recursively within folders if you flag it to' do
    expected_result =
    <<~TABLE
               x          | /Users/sashacooper/Desktop/pogroms/jobs/hellgrid | spec/tmp/bar | spec/tmp/in/foo 
      --------------------+--------------------------------------------------+--------------+-----------------
            diff-lcs      |                      1.2.5                       |    1.2.5     |      1.2.5      
             rspec        |                      3.4.0                       |    2.0.0     |      3.0.0      
           rspec-core     |                      3.4.2                       |    2.0.0     |      3.0.4      
       rspec-expectations |                      3.4.0                       |    2.0.0     |      3.0.4      
          rspec-mocks     |                      3.4.1                       |    2.0.0     |      3.0.4      
              rake        |                        x                         |    10.0.0    |     11.1.0      
         rspec-support    |                      3.4.1                       |      x       |      3.0.4      
            hellgrid      |                      0.1.0                       |      x       |        x        
    TABLE

    Bundler.with_clean_env do
      expect(`cd #{PROJECT_ROOT} && hellgrid -r`).to eq(expected_result)
    end
  end
end
