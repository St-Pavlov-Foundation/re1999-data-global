module("modules.common.others.SDKDataTrackExt", package.seeall)

slot0 = SDKDataTrackMgr

function slot0.activateExtend()
	uv0.EventProperties.notice_jump_id = "jump_id"
	uv0.EventName.voice_pack_UI_manager = "voice_pack_UI_manager"
	uv0.EventName.voice_pack_download_confirm = "voice_pack_download_confirm"
	uv0.EventName.voice_pack_downloading = "voice_pack_downloading"
	uv0.EventName.voice_pack_switch = "voice_pack_switch"
	uv0.EventName.voice_pack_delete = "voice_pack_delete"
	uv0.EventName.resources_downloading = "resources_downloading"
	uv0.EventName.main_hero_interaction = "main_hero_interaction"
	uv0.EventProperties.current_language = "current_language"
	uv0.EventProperties.entrance = "entrance"
	uv0.EventProperties.current_voice_pack_list = "current_voice_pack_list"
	uv0.EventProperties.current_voice_pack_used = "current_voice_pack_used"
	uv0.EventProperties.download_voice_pack_list = "download_voice_pack_list"
	uv0.EventProperties.update_amount = "update_amount"
	uv0.EventProperties.step = "step"
	uv0.EventProperties.voice_pack_before = "voice_pack_before"
	uv0.EventProperties.voice_pack_delete = "voice_pack_delete"
	uv0.EventProperties.resource_type = "resource_type"
	uv0.EventProperties.main_hero_interaction_skin_id = "skinid"
	uv0.EventProperties.main_hero_interaction_area_id = "area_id"
	uv0.EventProperties.main_hero_interaction_voice_id = "voiceid"
	uv0.PropertyTypes[uv0.EventProperties.current_language] = "string"
	uv0.PropertyTypes[uv0.EventProperties.entrance] = "string"
	uv0.PropertyTypes[uv0.EventProperties.current_voice_pack_list] = "list"
	uv0.PropertyTypes[uv0.EventProperties.current_voice_pack_used] = "string"
	uv0.PropertyTypes[uv0.EventProperties.download_voice_pack_list] = "list"
	uv0.PropertyTypes[uv0.EventProperties.update_amount] = "number"
	uv0.PropertyTypes[uv0.EventProperties.step] = "string"
	uv0.PropertyTypes[uv0.EventProperties.voice_pack_before] = "string"
	uv0.PropertyTypes[uv0.EventProperties.voice_pack_delete] = "string"
	uv0.PropertyTypes[uv0.EventProperties.resource_type] = "list"
	uv0.PropertyTypes[uv0.EventProperties.main_hero_interaction_skin_id] = "number"
	uv0.PropertyTypes[uv0.EventProperties.main_hero_interaction_area_id] = "number"
	uv0.PropertyTypes[uv0.EventProperties.main_hero_interaction_voice_id] = "string"
end

function slot0.trackVoicePackDownloadConfirm(slot0, slot1)
	uv0.instance:track(uv0.EventName.voice_pack_download_confirm, {
		[uv0.EventProperties.current_language] = GameConfig:GetCurLangShortcut(),
		[uv0.EventProperties.current_voice_pack_used] = GameConfig:GetCurVoiceShortcut(),
		[uv0.EventProperties.current_voice_pack_list] = slot1.current_voice_pack_list or {},
		[uv0.EventProperties.download_voice_pack_list] = slot1.download_voice_pack_list or {},
		[uv0.EventProperties.entrance] = slot1.entrance,
		[uv0.EventProperties.update_amount] = slot1.update_amount or 0
	})
end

function slot0.trackVoicePackDownloading(slot0, slot1)
	uv0.instance:track(uv0.EventName.voice_pack_downloading, {
		[uv0.EventProperties.step] = slot1.step,
		[uv0.EventProperties.download_voice_pack_list] = slot1.download_voice_pack_list or {},
		[uv0.EventProperties.update_amount] = slot1.update_amount or 0,
		[uv0.EventProperties.spend_time] = slot1.spend_time or 0,
		[uv0.EventProperties.result_msg] = slot1.result_msg or ""
	})
end

function slot0.trackVoicePackSwitch(slot0, slot1)
	uv0.instance:track(uv0.EventName.voice_pack_switch, {
		[uv0.EventProperties.current_language] = slot1.current_language,
		[uv0.EventProperties.entrance] = slot1.entrance or "",
		[uv0.EventProperties.current_voice_pack_list] = slot1.current_voice_pack_list or {},
		[uv0.EventProperties.current_voice_pack_used] = slot1.current_voice_pack_used or "",
		[uv0.EventProperties.voice_pack_before] = slot1.voice_pack_before or ""
	})
end

function slot0.trackVoicePackDelete(slot0, slot1)
	uv0.instance:track(uv0.EventName.voice_pack_delete, {
		[uv0.EventProperties.current_language] = slot1.current_language,
		[uv0.EventProperties.current_voice_pack_list] = slot1.current_voice_pack_list or {},
		[uv0.EventProperties.current_voice_pack_used] = slot1.current_voice_pack_used or "",
		[uv0.EventProperties.voice_pack_delete] = slot1.voice_pack_delete or ""
	})
end

function slot0.trackOptionPackDownloading(slot0, slot1)
	uv0.instance:track(uv0.EventName.resources_downloading, {
		[uv0.EventProperties.step] = slot1.step,
		[uv0.EventProperties.resource_type] = slot1.resource_type or {},
		[uv0.EventProperties.update_amount] = slot1.update_amount or 0,
		[uv0.EventProperties.spend_time] = slot1.spend_time or 0,
		[uv0.EventProperties.result_msg] = slot1.result_msg or ""
	})
end

function slot0.trackOptionPackConfirmDownload(slot0, slot1)
	uv0.instance:track(uv0.EventName.confirm_download_resources, {
		[uv0.EventProperties.resource_type] = slot1.resource_type or {}
	})
end

function slot0.trackMainHeroInteraction(slot0, slot1)
	uv0.instance:track(uv0.EventName.main_hero_interaction, {
		[uv0.EventProperties.main_hero_interaction_skin_id] = slot1.main_hero_interaction_skin_id or -1,
		[uv0.EventProperties.main_hero_interaction_area_id] = slot1.main_hero_interaction_area_id or -1,
		[uv0.EventProperties.main_hero_interaction_voice_id] = slot1.main_hero_interaction_voice_id or ""
	})
end

return slot0
