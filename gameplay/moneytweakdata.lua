local difficulty = Global.game_settings and Global.game_settings.difficulty or "easy"
local data = MoneyTweakData.init
function MoneyTweakData:init(tweak_data)
	data(self, tweak_data)
	
	table.insert(self.difficulty_multiplier, 5, 30)
	table.insert(self.difficulty_multiplier, 50)

	table.insert(self.mission_asset_cost_multiplier_by_risk, 4, 3)
	table.insert(self.mission_asset_cost_multiplier_by_risk, 5)
	
	if self.preplaning_asset_cost_multiplier_by_risk then
		table.insert(self.preplaning_asset_cost_multiplier_by_risk, 5, 11)
		table.insert(self.preplaning_asset_cost_multiplier_by_risk, 20)
	end
	
	if difficulty == "easy_wish" or difficulty == "sm_wish" then
		self.small_loot.diamondheist_vault_bust = 12000
		self.small_loot.diamondheist_vault_diamond = 15000
		self.small_loot.diamondheist_big_diamond = 15000
		self.small_loot.mus_small_artifact = 9500
		self.small_loot.gen_atm = 300000
		self.small_loot.slot_machine_payout = 325000
		self.small_loot.vault_loot_chest = 7500
		self.small_loot.vault_loot_diamond_chest = 8000
		self.small_loot.vault_loot_banknotes = 6500
		self.small_loot.vault_loot_silver = 7000
		self.small_loot.vault_loot_diamond_collection = 8500
		self.small_loot.vault_loot_trophy = 9000
		self.small_loot.money_wrap_single_bundle_vscaled = 5000
		self.small_loot.spawn_bucket_of_money = 260000
		self.small_loot.vault_loot_gold = 30000
		self.small_loot.vault_loot_cash = 15000
		self.small_loot.vault_loot_coins = 10500
		self.small_loot.vault_loot_ring = 4500
		self.small_loot.vault_loot_jewels = 7500
		self.small_loot.federali_medal = 11000
	end
end
