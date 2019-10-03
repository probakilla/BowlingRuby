RUBY=ruby
MAIN=src/main.rb
TEST_MAIN=tests/test_suite_runner.rb

all: run

run: $(MAIN)
	$(RUBY) $<

test: $(TEST_MAIN)
	$(RUBY) $<
