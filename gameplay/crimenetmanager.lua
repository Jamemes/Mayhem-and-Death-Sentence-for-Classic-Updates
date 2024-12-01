if not NarrativeTweakData.job_data then
	function NarrativeTweakData:job_data(job_id, unique_to_job)
		if not job_id or not self.jobs[job_id] then
			return
		end
		if unique_to_job then
			return self.jobs[job_id]
		end
		if self.jobs[job_id].wrapped_to_job then
			return self.jobs[self.jobs[job_id].wrapped_to_job]
		end
		return self.jobs[job_id]
	end
end

function CrimeNetManager:_get_jobs_by_jc()
	local t = {}
	local plvl = managers.experience:current_level()
	local prank = managers.experience:current_rank()
	for _, job_id in ipairs(tweak_data.narrative:get_jobs_index()) do
		local is_cooldown_ok = managers.job:check_ok_with_cooldown(job_id)
		local is_not_wrapped = not tweak_data.narrative.jobs[job_id].wrapped_to_job
		local dlc = tweak_data.narrative:job_data(job_id).dlc
		local is_not_dlc_or_got = not dlc or managers.dlc:has_dlc(dlc)
		local pass_all_tests = is_cooldown_ok and is_not_wrapped and is_not_dlc_or_got
		if pass_all_tests then
			local job_data = tweak_data.narrative:job_data(job_id)
			local start_difficulty = job_data.professional and 1 or 0
			for i = start_difficulty, 6 do
				local job_jc = math.clamp(job_data.jc + i * 10, 0, 100)
				local difficulty_id = 2 + i
				local difficulty = tweak_data:index_to_difficulty(difficulty_id)
				local level_lock = tweak_data.difficulty_level_locks[difficulty_id] or 0
				local is_not_level_locked = prank >= 1 or plvl >= level_lock
				if is_not_level_locked then
					t[job_jc] = t[job_jc] or {}
					table.insert(t[job_jc], {
						job_id = job_id,
						difficulty_id = difficulty_id,
						difficulty = difficulty
					})
				end
			end
		else
			print("SKIP DUE TO COOLDOWN OR THE JOB IS WRAPPED INSIDE AN OTHER JOB", job_id)
		end
	end
	return t
end

function CrimeNetGui:custom_gui(job)
	local stars_panel = job.side_panel:child("stars_panel")
	stars_panel:clear()
	stars_panel:set_w(100)
	
	if job.job_id then
		local x = 0
		local y = 0
		local difficulty_stars = job.difficulty_id - 2
		local start_difficulty = 1
		local num_skulls = 6

		for i = start_difficulty, num_skulls do
			stars_panel:bitmap({
				texture = "guis/textures/pd2/cn_miniskull",
				x = x,
				y = y,
				w = 12,
				h = 16,
				texture_rect = {
					0,
					0,
					12,
					16
				},
				alpha = i > difficulty_stars and 0.5 or 1,
				blend_mode = i > difficulty_stars and "normal" or "add",
				layer = 0,
				color = i > difficulty_stars and Color.black or tweak_data.screen_colors.risk
			})

			x = x + 11
		end
		
	end
end

local gui = CrimeNetGui._create_job_gui
function CrimeNetGui:_create_job_gui(data, type, fixed_x, fixed_y, fixed_location)
	local gui_data = gui(self, data, type, fixed_x, fixed_y, fixed_location)
	self:custom_gui(gui_data)
	
	return gui_data
end

function CrimeNetManager:setup_new_difficulties(difficulty_id, diff, panel)
	local death_wish = panel:child("risk_murder_squad1")
	death_wish:set_color(diff >= 7 and tweak_data.screen_colors.risk or Color.white)
	death_wish:set_alpha(diff >= 7 and 1 or 0.25)
	
	local sm_wish = panel:child("risk_murder_squad2")
	sm_wish:set_color(diff == 8 and tweak_data.screen_colors.risk or Color.white)
	sm_wish:set_alpha(diff == 8 and 1 or 0.25)
	
	local risk_stats_panel = panel:child("risk_stats_panel")
	local dw_stat = risk_stats_panel:child("risk_murder_squad1")
	dw_stat:set_color(diff >= 7 and tweak_data.screen_colors.risk or Color.white)
	dw_stat:set_alpha(difficulty_id == diff and diff == 7 and 1 or 0.5)
	
	local sm_stat = risk_stats_panel:child("risk_murder_squad2")
	sm_stat:set_color(diff == 8 and tweak_data.screen_colors.risk or Color.white)
	sm_stat:set_alpha(difficulty_id == diff and diff == 8 and 1 or 0.5)
end