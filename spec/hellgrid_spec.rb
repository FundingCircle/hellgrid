# frozen_string_literal: true

require 'spec_helper'

describe 'bin/hellgrid' do
  def with_unbundled_env(&block)
    if Bundler.respond_to?(:with_unbundled_env)
      Bundler.with_unbundled_env(&block)
    else
      Bundler.with_clean_env(&block)
    end
  end

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

    create_file 'spec/tmp/bar/Gemfile.lock', <<~BAR_GEMFILE
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
               x          |  bar   | in/foo#{' '}
      --------------------+--------+--------
            diff-lcs      | 1.2.5  | 1.2.5#{'  '}
              rake        | 10.0.0 | 11.1.0#{' '}
             rspec        | 2.0.0  | 3.0.0#{'  '}
           rspec-core     | 2.0.0  | 3.0.4#{'  '}
       rspec-expectations | 2.0.0  | 3.0.4#{'  '}
          rspec-mocks     | 2.0.0  | 3.0.4#{'  '}
         rspec-support    |   x    | 3.0.4#{'  '}
    TABLE

    expect(`#{PROJECT_ROOT}/bin/hellgrid #{PROJECT_ROOT}/spec/tmp`).to eq(expected_result)
  end

  it 'could be run from random directory' do
    expected_result = <<~TABLE
               x          |  bar   | in/foo#{' '}
      --------------------+--------+--------
            diff-lcs      | 1.2.5  | 1.2.5#{'  '}
              rake        | 10.0.0 | 11.1.0#{' '}
             rspec        | 2.0.0  | 3.0.0#{'  '}
           rspec-core     | 2.0.0  | 3.0.4#{'  '}
       rspec-expectations | 2.0.0  | 3.0.4#{'  '}
          rspec-mocks     | 2.0.0  | 3.0.4#{'  '}
         rspec-support    |   x    | 3.0.4#{'  '}
    TABLE

    with_unbundled_env do
      expect(`cd ~ && #{PROJECT_ROOT}/bin/hellgrid #{PROJECT_ROOT}/spec/tmp`).to eq(expected_result)
    end
  end

  it 'uses the current working directory by default' do
    expected_result = <<~TABLE
               x          |  bar   | in/foo#{' '}
      --------------------+--------+--------
            diff-lcs      | 1.2.5  | 1.2.5#{'  '}
              rake        | 10.0.0 | 11.1.0#{' '}
             rspec        | 2.0.0  | 3.0.0#{'  '}
           rspec-core     | 2.0.0  | 3.0.4#{'  '}
       rspec-expectations | 2.0.0  | 3.0.4#{'  '}
          rspec-mocks     | 2.0.0  | 3.0.4#{'  '}
         rspec-support    |   x    | 3.0.4#{'  '}
    TABLE

    with_unbundled_env do
      expect(`cd #{PROJECT_ROOT}/spec/tmp && #{PROJECT_ROOT}/bin/hellgrid`).to eq(expected_result)
    end
  end

  context 'when passing -r' do
    it 'searches recursively within folders if you flag it to' do
      with_unbundled_env do
        expect(`cd #{PROJECT_ROOT} && #{PROJECT_ROOT}/bin/hellgrid -r`.lines.first).to(
          include(
            'hellgrid',
            'spec/tmp/bar',
            'spec/tmp/in/foo'
          )
        )
      end
    end
  end

  context 'when passing -t' do
    it 'transposes the result and the project names on the left' do
      expected_result = <<~TABLE
           x    | diff-lcs |  rake  | rspec | rspec-core | rspec-expectations | rspec-mocks | rspec-support#{' '}
        --------+----------+--------+-------+------------+--------------------+-------------+---------------
          bar   |  1.2.5   | 10.0.0 | 2.0.0 |   2.0.0    |       2.0.0        |    2.0.0    |       x#{'       '}
         in/foo |  1.2.5   | 11.1.0 | 3.0.0 |   3.0.4    |       3.0.4        |    3.0.4    |     3.0.4#{'     '}
      TABLE

      with_unbundled_env do
        expect(`cd #{PROJECT_ROOT}/spec/tmp && #{PROJECT_ROOT}/bin/hellgrid -t`).to eq(expected_result)
      end
    end
  end
end
