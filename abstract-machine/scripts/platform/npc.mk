
run: image
	$(MAKE) -C $(NPC_HOME) sim IMG=$(IMAGE).bin
	# $(MAKE) -C $(NPC_HOME) run IMG=$(IMAGE).bin