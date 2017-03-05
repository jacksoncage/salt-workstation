.PHONY: install apply

all: install apply

apply:
	sudo salt-call state.apply --local --retcode-passthrough  --state-output=changes --file-root=./state --pillar-root=./pillar -l debug

apply-state:
	sudo salt-call state.apply --local --retcode-passthrough  --state-output=changes --file-root=./state --pillar-root=./pillar -l debug $(state)

install:
	sudo bash -x install.sh

# Start a clean container and run apply
#test-clean:
	
test-apply:
	sudo salt-call state.apply --local --retcode-passthrough  --state-output=mixed --file-root=./state --pillar-root=./pillar -l debug test=True

test-apply-state:
	sudo salt-call state.apply --local --retcode-passthrough  --state-output=mixed --file-root=./state --pillar-root=./pillar -l debug $(state) test=True


