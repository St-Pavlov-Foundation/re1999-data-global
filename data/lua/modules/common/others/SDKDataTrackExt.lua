-- chunkname: @modules/common/others/SDKDataTrackExt.lua

module("modules.common.others.SDKDataTrackExt", package.seeall)

local SDKDataTrackMgr = SDKDataTrackMgr

function SDKDataTrackMgr.activateExtend()
	SDKDataTrackMgr.EventProperties.notice_jump_id = "jump_id"
	SDKDataTrackMgr.EventName.voice_pack_UI_manager = "voice_pack_UI_manager"
	SDKDataTrackMgr.EventName.voice_pack_download_confirm = "voice_pack_download_confirm"
	SDKDataTrackMgr.EventName.voice_pack_downloading = "voice_pack_downloading"
	SDKDataTrackMgr.EventName.voice_pack_switch = "voice_pack_switch"
	SDKDataTrackMgr.EventName.voice_pack_delete = "voice_pack_delete"
	SDKDataTrackMgr.EventName.resources_downloading = "resources_downloading"
	SDKDataTrackMgr.EventName.main_hero_interaction = "main_hero_interaction"
	SDKDataTrackMgr.EventName.act210_operation = "act210_operation"
	SDKDataTrackMgr.EventName.resource_fixup = "resource_fixup"
	SDKDataTrackMgr.EventName.click_activity_jump_button = "click_activity_jump_button"
	SDKDataTrackMgr.EventProperties.current_language = "current_language"
	SDKDataTrackMgr.EventProperties.entrance = "entrance"
	SDKDataTrackMgr.EventProperties.current_voice_pack_list = "current_voice_pack_list"
	SDKDataTrackMgr.EventProperties.current_voice_pack_used = "current_voice_pack_used"
	SDKDataTrackMgr.EventProperties.download_voice_pack_list = "download_voice_pack_list"
	SDKDataTrackMgr.EventProperties.update_amount = "update_amount"
	SDKDataTrackMgr.EventProperties.step = "step"
	SDKDataTrackMgr.EventProperties.voice_pack_before = "voice_pack_before"
	SDKDataTrackMgr.EventProperties.voice_pack_delete = "voice_pack_delete"
	SDKDataTrackMgr.EventProperties.resource_type = "resource_type"
	SDKDataTrackMgr.EventProperties.main_hero_interaction_skin_id = "skinid"
	SDKDataTrackMgr.EventProperties.main_hero_interaction_area_id = "area_id"
	SDKDataTrackMgr.EventProperties.main_hero_interaction_voice_id = "voiceid"
	SDKDataTrackMgr.EventProperties.resource_fixup_status = "status"
	SDKDataTrackMgr.EventProperties.resource_fixup_count = "resource_count"
	SDKDataTrackMgr.EventProperties.act210_grid_info = "act210_grid_info"
	SDKDataTrackMgr.EventProperties.used_times = "used_times"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.current_language] = "string"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.entrance] = "string"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.current_voice_pack_list] = "list"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.current_voice_pack_used] = "string"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.download_voice_pack_list] = "list"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.update_amount] = "number"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.step] = "string"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.voice_pack_before] = "string"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.voice_pack_delete] = "string"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.resource_type] = "list"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.main_hero_interaction_skin_id] = "number"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.main_hero_interaction_area_id] = "number"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.main_hero_interaction_voice_id] = "string"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.resource_fixup_status] = "string"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.resource_fixup_count] = "number"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.act210_grid_info] = "array"
	SDKDataTrackMgr.PropertyTypes[SDKDataTrackMgr.EventProperties.used_times] = "number"
end

function SDKDataTrackMgr:trackVoicePackDownloadConfirm(data)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.voice_pack_download_confirm, {
		[SDKDataTrackMgr.EventProperties.current_language] = GameConfig:GetCurLangShortcut(),
		[SDKDataTrackMgr.EventProperties.current_voice_pack_used] = GameConfig:GetCurVoiceShortcut(),
		[SDKDataTrackMgr.EventProperties.current_voice_pack_list] = data.current_voice_pack_list or {},
		[SDKDataTrackMgr.EventProperties.download_voice_pack_list] = data.download_voice_pack_list or {},
		[SDKDataTrackMgr.EventProperties.entrance] = data.entrance,
		[SDKDataTrackMgr.EventProperties.update_amount] = data.update_amount or 0
	})
end

function SDKDataTrackMgr:trackVoicePackDownloading(data)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.voice_pack_downloading, {
		[SDKDataTrackMgr.EventProperties.step] = data.step,
		[SDKDataTrackMgr.EventProperties.download_voice_pack_list] = data.download_voice_pack_list or {},
		[SDKDataTrackMgr.EventProperties.update_amount] = data.update_amount or 0,
		[SDKDataTrackMgr.EventProperties.spend_time] = data.spend_time or 0,
		[SDKDataTrackMgr.EventProperties.result_msg] = data.result_msg or ""
	})
end

function SDKDataTrackMgr:trackVoicePackSwitch(data)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.voice_pack_switch, {
		[SDKDataTrackMgr.EventProperties.current_language] = data.current_language,
		[SDKDataTrackMgr.EventProperties.entrance] = data.entrance or "",
		[SDKDataTrackMgr.EventProperties.current_voice_pack_list] = data.current_voice_pack_list or {},
		[SDKDataTrackMgr.EventProperties.current_voice_pack_used] = data.current_voice_pack_used or "",
		[SDKDataTrackMgr.EventProperties.voice_pack_before] = data.voice_pack_before or ""
	})
end

function SDKDataTrackMgr:trackVoicePackDelete(data)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.voice_pack_delete, {
		[SDKDataTrackMgr.EventProperties.current_language] = data.current_language,
		[SDKDataTrackMgr.EventProperties.current_voice_pack_list] = data.current_voice_pack_list or {},
		[SDKDataTrackMgr.EventProperties.current_voice_pack_used] = data.current_voice_pack_used or "",
		[SDKDataTrackMgr.EventProperties.voice_pack_delete] = data.voice_pack_delete or ""
	})
end

function SDKDataTrackMgr:trackOptionPackDownloading(data)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.resources_downloading, {
		[SDKDataTrackMgr.EventProperties.step] = data.step,
		[SDKDataTrackMgr.EventProperties.resource_type] = data.resource_type or {},
		[SDKDataTrackMgr.EventProperties.update_amount] = data.update_amount or 0,
		[SDKDataTrackMgr.EventProperties.spend_time] = data.spend_time or 0,
		[SDKDataTrackMgr.EventProperties.result_msg] = data.result_msg or ""
	})
end

function SDKDataTrackMgr:trackOptionPackConfirmDownload(data)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.confirm_download_resources, {
		[SDKDataTrackMgr.EventProperties.resource_type] = data.resource_type or {}
	})
end

function SDKDataTrackMgr:trackMainHeroInteraction(data)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.main_hero_interaction, {
		[SDKDataTrackMgr.EventProperties.main_hero_interaction_skin_id] = data.main_hero_interaction_skin_id or -1,
		[SDKDataTrackMgr.EventProperties.main_hero_interaction_area_id] = data.main_hero_interaction_area_id or -1,
		[SDKDataTrackMgr.EventProperties.main_hero_interaction_voice_id] = data.main_hero_interaction_voice_id or ""
	})
end

function SDKDataTrackMgr:trackResourceFixup(data)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.resource_fixup, {
		[SDKDataTrackMgr.EventProperties.resource_fixup_status] = data.status or "",
		[SDKDataTrackMgr.EventProperties.resource_fixup_count] = data.count or 0,
		[SDKDataTrackMgr.EventProperties.entrance] = data.entrance or ""
	})
end

function SDKDataTrackMgr:trackClickActivityJumpButton()
	StatController.instance:track(SDKDataTrackMgr.EventName.click_activity_jump_button, {})
end

function SDKDataTrackMgr:trackClickEnterActivityButton(viewName, buttonName)
	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ViewName] = viewName or "",
		[StatEnum.EventProperties.ButtonName] = buttonName or ""
	})
end

function SDKDataTrackMgr:track_act210_operation(map_id, operation_type, act210_grid_info, used_times, usetime)
	StatController.instance:track(SDKDataTrackMgr.EventName.act210_operation, {
		[StatEnum.EventProperties.MapId] = tostring(map_id) or "",
		[StatEnum.EventProperties.OperationType] = operation_type or "",
		[SDKDataTrackMgr.EventProperties.act210_grid_info] = act210_grid_info or {},
		[SDKDataTrackMgr.EventProperties.used_times] = used_times or 0,
		[StatEnum.EventProperties.UseTime] = usetime or -1
	})
end

return SDKDataTrackMgr
