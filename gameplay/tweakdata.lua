local char = tweak_data.character
local group = tweak_data.group_ai
local difficulty = Global.game_settings and Global.game_settings.difficulty or "easy"

table.insert(tweak_data.difficulties, 6, "easy_wish")
table.insert(tweak_data.difficulty_level_locks, 6, 80)
table.insert(tweak_data.experience_manager.difficulty_multiplier, 4, 11)
tweak_data.difficulty_name_ids.easy_wish = "menu_difficulty_easy_wish"

table.insert(tweak_data.difficulties, "sm_wish")
table.insert(tweak_data.difficulty_level_locks, 80)
table.insert(tweak_data.experience_manager.difficulty_multiplier, 20)
tweak_data.difficulty_name_ids.sm_wish = "menu_difficulty_sm_wish"
	
for _, job in pairs(tweak_data.narrative.jobs) do
	if job.payout then
		table.insert(job.payout, 5, job.payout[5] * 0.9)
		table.insert(job.payout, job.payout[6] * 1.5)
	end
	
	if job.contract_cost then
		table.insert(job.contract_cost, 5, job.contract_cost[5] * 0.9)
		table.insert(job.contract_cost, job.contract_cost[6] * 1.5)
	end
	
	if job.experience_mul then
		table.insert(job.experience_mul, 5, job.experience_mul[5])
		table.insert(job.experience_mul, job.experience_mul[5])
	end
end

if difficulty == "easy_wish" then
	tweak_data:_set_overkill_145()
	tweak_data.character:_multiply_all_hp(1.7, 0.75)
	tweak_data.character.fbi_swat.HEALTH_INIT = tweak_data.character.fbi_swat.HEALTH_INIT * 1.7
	tweak_data.character.fbi_swat.headshot_dmg_mul = tweak_data.character.fbi_swat.headshot_dmg_mul * 0.75
	tweak_data.player:_set_overkill_290()
	tweak_data.player.damage.REVIVE_HEALTH_STEPS = {0.4}
	group.unit_categories.FBI_swat_M4.units = {Idstring("units/payday2/characters/ene_fbi_swat_1/ene_fbi_swat_1")}
	group.unit_categories.FBI_swat_R870.units = {Idstring("units/payday2/characters/ene_fbi_swat_2/ene_fbi_swat_2")}
	group.unit_categories.FBI_tank.units = {
		Idstring("units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1"),
		Idstring("units/payday2/characters/ene_bulldozer_2/ene_bulldozer_2")
	}
	tweak_data.player.damage.automatic_respawn_time = nil
elseif difficulty == "sm_wish" then
	local data = tweak_data.character._multiply_all_hp
	function tweak_data.character:_multiply_all_hp(hp, hs)
		data(self, 6, 1.5)
	end

	tweak_data.player.damage.automatic_respawn_time = nil
	tweak_data.weapon.m4_npc.DAMAGE = 3
	tweak_data.weapon.g36_npc.DAMAGE = 5
	tweak_data.weapon.r870_npc.DAMAGE = 7
	
	char.security.HEALTH_INIT = 4
	char.security.headshot_dmg_mul = 2
	char.gensec.HEALTH_INIT = 4
	char.gensec.headshot_dmg_mul = 2
	char.cop.HEALTH_INIT = 4
	char.cop.headshot_dmg_mul = 2
	char.fbi.HEALTH_INIT = 8
	char.fbi.headshot_dmg_mul = 2
	char.swat.headshot_dmg_mul = 2
	char.heavy_swat.HEALTH_INIT = 16
	char.heavy_swat.headshot_dmg_mul = 2
	char.heavy_swat.damage.explosion_damage_mul = 0.9
	char.fbi_swat.HEALTH_INIT = 8
	char.fbi_swat.headshot_dmg_mul = 2
	char.fbi_heavy_swat.HEALTH_INIT = 16
	char.fbi_heavy_swat.headshot_dmg_mul = 2
	char.gangster.HEALTH_INIT = 8
	char.tank.HEALTH_INIT = 200
	char.shield.HEALTH_INIT = 8
	char.shield.headshot_dmg_mul = 2
	char.taser.HEALTH_INIT = 30
	char.taser.headshot_dmg_mul = 2
	char.spooc.headshot_dmg_mul = 6
	
	char.tank.move_speed = tweak_data.character.presets.move_speed.slow
	char.tank.damage.hurt_severity = tweak_data.character.presets.hurt_severities.no_hurts
	
	tweak_data:_set_overkill_290()

	char.fbi_swat.weapon = tweak_data.character.presets.weapon.deathwish
	char.fbi_heavy_swat.weapon = tweak_data.character.presets.weapon.deathwish
	
	if PackageManager:package_exists("packages/sm_wish") and PackageManager:loaded("packages/sm_wish") then
		group.unit_categories.spooc.units = {Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_cloaker/ene_zeal_cloaker")}
		group.unit_categories.FBI_swat_M4.units = {Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat/ene_zeal_swat")}
		group.unit_categories.FBI_swat_R870.units = {Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat/ene_zeal_swat")}
		group.unit_categories.FBI_heavy_G36.units = {Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat_heavy/ene_zeal_swat_heavy")}
		group.unit_categories.FBI_heavy_G36_w.units = {Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat_heavy/ene_zeal_swat_heavy")}
		group.unit_categories.FBI_shield.units = {Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_swat_shield/ene_zeal_swat_shield")}
		group.unit_categories.CS_tazer.units = {Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_tazer/ene_zeal_tazer")}
		group.unit_categories.FBI_tank.units = {
			Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer/ene_zeal_bulldozer"),
			Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer_2/ene_zeal_bulldozer_2"),
			Idstring("units/pd2_dlc_gitgud/characters/ene_zeal_bulldozer_3/ene_zeal_bulldozer_3"),
		}
	else
		group.unit_categories.FBI_swat_M4.units = {Idstring("units/payday2/characters/ene_swat_1/ene_swat_1")}
		group.unit_categories.FBI_swat_R870.units = {Idstring("units/payday2/characters/ene_swat_1/ene_swat_1")}
		-- group.unit_categories.FBI_heavy_G36.units = {Idstring("units/payday2/characters/ene_swat_heavy_1/ene_swat_heavy_1")}
		-- group.unit_categories.FBI_heavy_G36_w.units = {Idstring("units/payday2/characters/ene_swat_heavy_1/ene_swat_heavy_1")}
		group.unit_categories.FBI_tank.units = {
			Idstring("units/payday2/characters/ene_bulldozer_3/ene_bulldozer_3"),
			Idstring("units/payday2/characters/ene_bulldozer_1/ene_bulldozer_1"),
			Idstring("units/payday2/characters/ene_bulldozer_2/ene_bulldozer_2"),
		}
	end
	
	group.special_unit_spawn_limits = {
		shield = 4,
		taser = 3,
		tank = 3,
		spooc = 2
	}
	group.besiege.assault.sustain_duration_min = {
		40,
		120,
		160
	}
	group.besiege.assault.sustain_duration_max = {
		40,
		120,
		160
	}
	group.besiege.assault.force = {
		14,
		16,
		18
	}
	group.besiege.assault.force_pool = {
		150,
		175,
		225
	}
	group.besiege.assault.force_balance_mul = {
		1.5,
		3,
		4.5,
		6
	}
	group.besiege.assault.force_pool_balance_mul = {
		1.5,
		3,
		4.5,
		6
	}

	group._tactics = {
		swat_shotgun_rush = {
			"charge",
			"provide_coverfire",
			"provide_support",
			"deathguard",
			"flash_grenade"
		},
		swat_shotgun_flank = {
			"charge",
			"provide_coverfire",
			"provide_support",
			"flank",
			"deathguard",
			"flash_grenade"
		},
		swat_rifle = {
			"ranged_fire",
			"provide_coverfire",
			"provide_support"
		},
		swat_rifle_flank = {
			"ranged_fire",
			"provide_coverfire",
			"provide_support",
			"flank",
			"flash_grenade"
		},
		shield_wall_ranged = {
			"shield",
			"ranged_fire",
			"provide_support "
		},
		shield_support_ranged = {
			"shield_cover",
			"ranged_fire",
			"provide_coverfire"
		},
		shield_wall_charge = {
			"shield",
			"charge",
			"provide_support "
		},
		shield_support_charge = {
			"shield_cover",
			"charge",
			"provide_coverfire",
			"flash_grenade"
		},
		shield_wall = {
			"shield",
			"ranged_fire",
			"provide_support",
			"murder",
			"deathguard"
		},
		tazer_flanking = {
			"flanking",
			"charge",
			"provide_coverfire",
			"smoke_grenade",
			"murder"
		},
		tazer_charge = {
			"charge",
			"provide_coverfire",
			"murder"
		},
		tank_rush = {
			"charge",
			"provide_coverfire",
			"murder"
		},
		spooc = {
			"charge",
			"shield_cover",
			"smoke_grenade"
		}
	}
	group.enemy_spawn_groups = {}

	group.enemy_spawn_groups.CS_defend_a = {
		amount = {
			4,
			5
		},
		spawn = {
			{
				amount_min = 1,
				freq = 1,
				amount_max = 1,
				rank = 2,
				unit = "FBI_swat_R870",
				tactics = group._tactics.swat_shotgun_rush
			},
			{
				amount_min = 3,
				freq = 3,
				amount_max = 3,
				rank = 3,
				unit = "FBI_heavy_R870",
				tactics = group._tactics.swat_shotgun_rush
			},
			{
				amount_min = 1,
				freq = 0.35,
				amount_max = 1,
				rank = 2,
				unit = "FBI_heavy_R870",
				tactics = group._tactics.swat_shotgun_rush
			}
		}
	}
	group.enemy_spawn_groups.CS_defend_b = {
		amount = {
			4,
			5
		},
		spawn = {
			{
				amount_min = 1,
				freq = 1,
				amount_max = 1,
				rank = 2,
				unit = "FBI_swat_R870",
				tactics = group._tactics.swat_shotgun_flank
			},
			{
				amount_min = 3,
				freq = 3,
				amount_max = 3,
				rank = 3,
				unit = "FBI_heavy_R870",
				tactics = group._tactics.swat_shotgun_flank
			},
			{
				amount_min = 0,
				freq = 0.5,
				amount_max = 1,
				rank = 2,
				unit = "FBI_heavy_R870",
				tactics = group._tactics.swat_shotgun_flank
			}
		}
	}
	group.enemy_spawn_groups.CS_defend_c = {
		amount = {
			4,
			5
		},
		spawn = {
			{
				amount_min = 1,
				freq = 1,
				amount_max = 1,
				rank = 2,
				unit = "FBI_swat_M4",
				tactics = group._tactics.swat_rifle
			},
			{
				amount_min = 3,
				freq = 3,
				amount_max = 3,
				rank = 3,
				unit = "FBI_heavy_G36",
				tactics = group._tactics.swat_rifle
			},
			{
				amount_min = 0,
				freq = 0.5,
				amount_max = 1,
				rank = 2,
				unit = "FBI_heavy_G36",
				tactics = group._tactics.swat_rifle
			}
		}
	}
	group.enemy_spawn_groups.CS_defend_d = {
		amount = {
			4,
			5
		},
		spawn = {
			{
				amount_min = 1,
				freq = 1,
				amount_max = 1,
				rank = 2,
				unit = "FBI_swat_M4",
				tactics = group._tactics.swat_rifle_flank
			},
			{
				amount_min = 3,
				freq = 3,
				amount_max = 3,
				rank = 3,
				unit = "FBI_heavy_G36",
				tactics = group._tactics.swat_rifle_flank
			},
			{
				amount_min = 0,
				freq = 0.35,
				amount_max = 1,
				rank = 2,
				unit = "FBI_heavy_G36",
				tactics = group._tactics.swat_rifle_flank
			}
		}
	}
	group.enemy_spawn_groups.CS_stealth_a = {
		amount = {
			4,
			5
		},
		spawn = {
			{
				amount_min = 2,
				freq = 2,
				amount_max = 2,
				rank = 2,
				unit = "FBI_heavy_G36",
				tactics = group._tactics.shield_support_ranged
			},
			{
				amount_min = 2,
				freq = 2,
				amount_max = 2,
				rank = 3,
				unit = "FBI_shield",
				tactics = group._tactics.shield_wall_ranged
			},
			{
				amount_min = 0,
				freq = 0.5,
				amount_max = 1,
				rank = 2,
				unit = "FBI_heavy_G36",
				tactics = group._tactics.shield_support_charge
			}
		}
	}
	group.enemy_spawn_groups.CS_stealth_b = {
		amount = {
			4,
			5
		},
		spawn = {
			{
				amount_min = 2,
				freq = 2,
				amount_max = 2,
				rank = 2,
				unit = "FBI_heavy_R870",
				tactics = group._tactics.shield_support_charge
			},
			{
				amount_min = 2,
				freq = 2,
				amount_max = 2,
				rank = 3,
				unit = "FBI_shield",
				tactics = group._tactics.shield_wall_charge
			},
			{
				amount_min = 0,
				freq = 0.5,
				amount_max = 1,
				rank = 2,
				unit = "FBI_heavy_R870",
				tactics = group._tactics.shield_support_charge
			}
		}
	}
	group.enemy_spawn_groups.CS_swats = {
		amount = {
			4,
			5
		},
		spawn = {
			{
				amount_min = 4,
				freq = 4,
				amount_max = 4,
				rank = 3,
				unit = "FBI_shield",
				tactics = group._tactics.shield_wall
			},
			{
				amount_min = 0,
				freq = 0.5,
				amount_max = 1,
				rank = 3,
				unit = "FBI_heavy_G36",
				tactics = group._tactics.shield_wall
			}
		}
	}
	group.enemy_spawn_groups.CS_heavys = {
		amount = {
			6,
			6
		},
		spawn = {
			{
				amount_min = 2,
				freq = 1,
				amount_max = 2,
				rank = 3,
				unit = "CS_tazer",
				tactics = group._tactics.tazer_flanking
			},
			{
				amount_min = 1,
				freq = 1,
				amount_max = 1,
				rank = 2,
				unit = "FBI_swat_M4",
				tactics = group._tactics.swat_rifle_flank
			},
			{
				amount_min = 3,
				freq = 3,
				amount_max = 3,
				rank = 3,
				unit = "FBI_heavy_G36",
				tactics = group._tactics.swat_rifle_flank
			}
		}
	}
	group.enemy_spawn_groups.CS_shields = {
		amount = {
			6,
			6
		},
		spawn = {
			{
				amount_min = 2,
				freq = 1,
				amount_max = 2,
				rank = 3,
				unit = "CS_tazer",
				tactics = group._tactics.tazer_charge
			},
			{
				amount_min = 1,
				freq = 1,
				amount_max = 1,
				rank = 2,
				unit = "FBI_swat_M4",
				tactics = group._tactics.swat_rifle_flank
			},
			{
				amount_min = 3,
				freq = 3,
				amount_max = 3,
				rank = 3,
				unit = "FBI_heavy_G36",
				tactics = group._tactics.swat_rifle_flank
			}
		}
	}
	group.enemy_spawn_groups.FBI_tanks = {
		amount = {
			6,
			6
		},
		spawn = {
			{
				amount_min = 2,
				freq = 1,
				amount_max = 2,
				rank = 3,
				unit = "FBI_tank",
				tactics = group._tactics.tank_rush
			},
			{
				amount_min = 1,
				freq = 1,
				amount_max = 1,
				rank = 2,
				unit = "FBI_swat_M4",
				tactics = group._tactics.swat_rifle_flank
			},
			{
				amount_min = 3,
				freq = 3,
				amount_max = 3,
				rank = 3,
				unit = "FBI_heavy_G36",
				tactics = group._tactics.swat_rifle_flank
			}
		}
	}
	group.enemy_spawn_groups.single_spooc = {
		amount = {
			1,
			1
		},
		spawn = {
			{
				freq = 1,
				amount_min = 1,
				rank = 1,
				unit = "spooc",
				tactics = group._tactics.spooc
			}
		}
	}
	group.enemy_spawn_groups.FBI_spoocs = group.enemy_spawn_groups.single_spooc
	
	group.besiege.assault.groups = {
		CS_defend_a = {
			0.18,
			0.18,
			0.18
		},
		CS_defend_b = {
			0.18,
			0.18,
			0.18
		},
		CS_defend_c = {
			0.18,
			0.18,
			0.18
		},
		CS_defend_d = {
			0.18,
			0.18,
			0.18
		},
		CS_stealth_a = {
			0.03,
			0.03,
			0.03
		},
		CS_stealth_b = {
			0.04,
			0.04,
			0.04
		},
		CS_swats = {
			0.03,
			0.03,
			0.03
		},
		CS_heavys = {
			0.05,
			0.05,
			0.05
		},
		CS_shields = {
			0.05,
			0.05,
			0.05
		},
		FBI_spoocs = {
			0.05,
			0.05,
			0.05
		},
		FBI_tanks = {
			0.05,
			0.05,
			0.05
		},
		single_spooc = {
			0,
			0,
			0
		}
	}
	
	group.besiege.reenforce.groups = {
		CS_defend_a = {
			0.1,
			0.1,
			0.1
		},
		CS_defend_b = {
			0.1,
			0.1,
			0.1
		},
		CS_defend_c = {
			0.1,
			0.1,
			0.1
		},
		CS_defend_d = {
			0.1,
			0.1,
			0.1
		}
	}
	
	group.besiege.recon.force = {
		3,
		4,
		6
	}
	
	group.besiege.recon.groups = {
		CS_defend_a = {
			0.1,
			0.1,
			0.1
		},
		CS_defend_b = {
			0.1,
			0.1,
			0.1
		},
		CS_defend_c = {
			0.1,
			0.1,
			0.1
		},
		CS_defend_d = {
			0.1,
			0.1,
			0.1
		},
		single_spooc = {
			0,
			0,
			0
		}
	}
end