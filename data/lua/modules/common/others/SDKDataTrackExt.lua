module("modules.common.others.SDKDataTrackExt", package.seeall)

local var_0_0 = SDKDataTrackMgr

function var_0_0.activateExtend()
	var_0_0.EventProperties.notice_jump_id = "jump_id"
	var_0_0.EventName.voice_pack_UI_manager = "voice_pack_UI_manager"
	var_0_0.EventName.voice_pack_download_confirm = "voice_pack_download_confirm"
	var_0_0.EventName.voice_pack_downloading = "voice_pack_downloading"
	var_0_0.EventName.voice_pack_switch = "voice_pack_switch"
	var_0_0.EventName.voice_pack_delete = "voice_pack_delete"
	var_0_0.EventName.resources_downloading = "resources_downloading"
	var_0_0.EventName.main_hero_interaction = "main_hero_interaction"
	var_0_0.EventName.act210_operation = "act210_operation"
	var_0_0.EventName.resource_fixup = "resource_fixup"
	var_0_0.EventName.click_activity_jump_button = "click_activity_jump_button"
	var_0_0.EventProperties.current_language = "current_language"
	var_0_0.EventProperties.entrance = "entrance"
	var_0_0.EventProperties.current_voice_pack_list = "current_voice_pack_list"
	var_0_0.EventProperties.current_voice_pack_used = "current_voice_pack_used"
	var_0_0.EventProperties.download_voice_pack_list = "download_voice_pack_list"
	var_0_0.EventProperties.update_amount = "update_amount"
	var_0_0.EventProperties.step = "step"
	var_0_0.EventProperties.voice_pack_before = "voice_pack_before"
	var_0_0.EventProperties.voice_pack_delete = "voice_pack_delete"
	var_0_0.EventProperties.resource_type = "resource_type"
	var_0_0.EventProperties.main_hero_interaction_skin_id = "skinid"
	var_0_0.EventProperties.main_hero_interaction_area_id = "area_id"
	var_0_0.EventProperties.main_hero_interaction_voice_id = "voiceid"
	var_0_0.EventProperties.resource_fixup_status = "status"
	var_0_0.EventProperties.resource_fixup_count = "resource_count"
	var_0_0.EventProperties.act210_grid_info = "act210_grid_info"
	var_0_0.EventProperties.used_times = "used_times"
	var_0_0.PropertyTypes[var_0_0.EventProperties.current_language] = "string"
	var_0_0.PropertyTypes[var_0_0.EventProperties.entrance] = "string"
	var_0_0.PropertyTypes[var_0_0.EventProperties.current_voice_pack_list] = "list"
	var_0_0.PropertyTypes[var_0_0.EventProperties.current_voice_pack_used] = "string"
	var_0_0.PropertyTypes[var_0_0.EventProperties.download_voice_pack_list] = "list"
	var_0_0.PropertyTypes[var_0_0.EventProperties.update_amount] = "number"
	var_0_0.PropertyTypes[var_0_0.EventProperties.step] = "string"
	var_0_0.PropertyTypes[var_0_0.EventProperties.voice_pack_before] = "string"
	var_0_0.PropertyTypes[var_0_0.EventProperties.voice_pack_delete] = "string"
	var_0_0.PropertyTypes[var_0_0.EventProperties.resource_type] = "list"
	var_0_0.PropertyTypes[var_0_0.EventProperties.main_hero_interaction_skin_id] = "number"
	var_0_0.PropertyTypes[var_0_0.EventProperties.main_hero_interaction_area_id] = "number"
	var_0_0.PropertyTypes[var_0_0.EventProperties.main_hero_interaction_voice_id] = "string"
	var_0_0.PropertyTypes[var_0_0.EventProperties.resource_fixup_status] = "string"
	var_0_0.PropertyTypes[var_0_0.EventProperties.resource_fixup_count] = "number"
	var_0_0.PropertyTypes[var_0_0.EventProperties.act210_grid_info] = "array"
	var_0_0.PropertyTypes[var_0_0.EventProperties.used_times] = "number"
end

function var_0_0.trackVoicePackDownloadConfirm(arg_2_0, arg_2_1)
	var_0_0.instance:track(var_0_0.EventName.voice_pack_download_confirm, {
		[var_0_0.EventProperties.current_language] = GameConfig:GetCurLangShortcut(),
		[var_0_0.EventProperties.current_voice_pack_used] = GameConfig:GetCurVoiceShortcut(),
		[var_0_0.EventProperties.current_voice_pack_list] = arg_2_1.current_voice_pack_list or {},
		[var_0_0.EventProperties.download_voice_pack_list] = arg_2_1.download_voice_pack_list or {},
		[var_0_0.EventProperties.entrance] = arg_2_1.entrance,
		[var_0_0.EventProperties.update_amount] = arg_2_1.update_amount or 0
	})
end

function var_0_0.trackVoicePackDownloading(arg_3_0, arg_3_1)
	var_0_0.instance:track(var_0_0.EventName.voice_pack_downloading, {
		[var_0_0.EventProperties.step] = arg_3_1.step,
		[var_0_0.EventProperties.download_voice_pack_list] = arg_3_1.download_voice_pack_list or {},
		[var_0_0.EventProperties.update_amount] = arg_3_1.update_amount or 0,
		[var_0_0.EventProperties.spend_time] = arg_3_1.spend_time or 0,
		[var_0_0.EventProperties.result_msg] = arg_3_1.result_msg or ""
	})
end

function var_0_0.trackVoicePackSwitch(arg_4_0, arg_4_1)
	var_0_0.instance:track(var_0_0.EventName.voice_pack_switch, {
		[var_0_0.EventProperties.current_language] = arg_4_1.current_language,
		[var_0_0.EventProperties.entrance] = arg_4_1.entrance or "",
		[var_0_0.EventProperties.current_voice_pack_list] = arg_4_1.current_voice_pack_list or {},
		[var_0_0.EventProperties.current_voice_pack_used] = arg_4_1.current_voice_pack_used or "",
		[var_0_0.EventProperties.voice_pack_before] = arg_4_1.voice_pack_before or ""
	})
end

function var_0_0.trackVoicePackDelete(arg_5_0, arg_5_1)
	var_0_0.instance:track(var_0_0.EventName.voice_pack_delete, {
		[var_0_0.EventProperties.current_language] = arg_5_1.current_language,
		[var_0_0.EventProperties.current_voice_pack_list] = arg_5_1.current_voice_pack_list or {},
		[var_0_0.EventProperties.current_voice_pack_used] = arg_5_1.current_voice_pack_used or "",
		[var_0_0.EventProperties.voice_pack_delete] = arg_5_1.voice_pack_delete or ""
	})
end

function var_0_0.trackOptionPackDownloading(arg_6_0, arg_6_1)
	var_0_0.instance:track(var_0_0.EventName.resources_downloading, {
		[var_0_0.EventProperties.step] = arg_6_1.step,
		[var_0_0.EventProperties.resource_type] = arg_6_1.resource_type or {},
		[var_0_0.EventProperties.update_amount] = arg_6_1.update_amount or 0,
		[var_0_0.EventProperties.spend_time] = arg_6_1.spend_time or 0,
		[var_0_0.EventProperties.result_msg] = arg_6_1.result_msg or ""
	})
end

function var_0_0.trackOptionPackConfirmDownload(arg_7_0, arg_7_1)
	var_0_0.instance:track(var_0_0.EventName.confirm_download_resources, {
		[var_0_0.EventProperties.resource_type] = arg_7_1.resource_type or {}
	})
end

function var_0_0.trackMainHeroInteraction(arg_8_0, arg_8_1)
	var_0_0.instance:track(var_0_0.EventName.main_hero_interaction, {
		[var_0_0.EventProperties.main_hero_interaction_skin_id] = arg_8_1.main_hero_interaction_skin_id or -1,
		[var_0_0.EventProperties.main_hero_interaction_area_id] = arg_8_1.main_hero_interaction_area_id or -1,
		[var_0_0.EventProperties.main_hero_interaction_voice_id] = arg_8_1.main_hero_interaction_voice_id or ""
	})
end

function var_0_0.trackResourceFixup(arg_9_0, arg_9_1)
	var_0_0.instance:track(var_0_0.EventName.resource_fixup, {
		[var_0_0.EventProperties.resource_fixup_status] = arg_9_1.status or "",
		[var_0_0.EventProperties.resource_fixup_count] = arg_9_1.count or 0,
		[var_0_0.EventProperties.entrance] = arg_9_1.entrance or ""
	})
end

function var_0_0.trackClickActivityJumpButton(arg_10_0)
	StatController.instance:track(var_0_0.EventName.click_activity_jump_button, {})
end

function var_0_0.trackClickEnterActivityButton(arg_11_0, arg_11_1, arg_11_2)
	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ViewName] = arg_11_1 or "",
		[StatEnum.EventProperties.ButtonName] = arg_11_2 or ""
	})
end

function var_0_0.track_act210_operation(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	StatController.instance:track(var_0_0.EventName.act210_operation, {
		[StatEnum.EventProperties.MapId] = tostring(arg_12_1) or "",
		[StatEnum.EventProperties.OperationType] = arg_12_2 or "",
		[var_0_0.EventProperties.act210_grid_info] = arg_12_3 or {},
		[var_0_0.EventProperties.used_times] = arg_12_4 or 0,
		[StatEnum.EventProperties.UseTime] = arg_12_5 or -1
	})
end

return var_0_0
