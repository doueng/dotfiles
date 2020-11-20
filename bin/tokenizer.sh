repo="$HOME/tokenizer/payment-forwardservice"
REGION=us-west-1 ENVIRONMENT=development REGION_SHORT=usw1 AWS_PROFILE=securevault-tokenizer-forwarder-webserver-dev-us-west-1 ENVIRONMENT_SHORT=dev java -jar $repo/forward-http-service/target/start.jar /Users/engstrand/dotfiles/bin/tokenizer.sh --spring.config.name=development | rg '\{' | tee $repo/rofl.log
