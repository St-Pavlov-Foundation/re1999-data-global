module("projbooter.sdk.SDKDataTrackMgr", package.seeall)

slot0 = class("SDKDataTrackMgr")

function slot0.trackNoticeLoad(slot0, slot1)
	uv0.instance:track(uv0.EventName.notice_load, {
		[uv0.EventProperties.notice_id] = slot1.notice_id or -1
	})
end

function slot0.trackNoticeJump(slot0, slot1)
	uv0.instance:track(uv0.EventName.notice_jump, {
		[uv0.EventProperties.notice_id] = slot1.notice_id or -1,
		[uv0.EventProperties.notice_jump_id] = slot1.notice_jump_id or -1
	})
end

slot0.EventName = {
	resources_downloading = "resources_downloading",
	hotupdate_41_60 = "hotupdate_41_60",
	resource_load = "resource_load",
	ChooseRole = "choose_role",
	hotupdate_request = "hotupdate_request",
	hotupdate_0_20 = "hotupdate_0_20",
	resource_load_finish = "resource_load_finish",
	notice_load = "notice_load",
	ChooseServer = "choose_server",
	hotupdate_files_check = "hotupdate_files_check",
	voice_pack_UI_manager = "voice_pack_UI_manager",
	hotupdate_61_80 = "hotupdate_61_80",
	hotupdate_download = "hotupdate_download",
	hotupdate_files_check_fail = "hotupdate_files_check_fail",
	notice_jump = "notice_jump",
	hotupdate_81_100 = "hotupdate_81_100",
	HotUpdate = "hot_update",
	event_hostswitch = "event_hostswitch",
	voice_pack_delete = "voice_pack_delete",
	unzip_finish = "unzip_finish",
	unzip_start = "unzip_start",
	main_hero_interaction = "main_hero_interaction",
	voice_pack_switch = "voice_pack_switch",
	start_game = "start_game",
	hotupdate_21_40 = "hotupdate_21_40",
	voice_pack_downloading = "voice_pack_downloading",
	socket_connect = "socket_connect",
	hotupdate_request_resource = "hotupdate_request_resource",
	confirm_download_resources = "confirm_download_resources",
	first_socket_connect = "first_socket_connect",
	hotupdate_check = "hotupdate_check",
	voice_pack_download_confirm = "voice_pack_download_confirm",
	resource_load_fail = "resource_load_fail",
	unzip_finish_fail = "unzip_finish_fail"
}
slot0.EventProperties = {
	data_length = "data_length",
	UpdateAmount = "update_amount",
	host_ip = "host_ip",
	current_language = "current_language",
	main_hero_interaction_voice_id = "voiceid",
	notice_jump_id = "jump_id",
	update_amount = "update_amount",
	spend_time = "spend_time",
	voice_pack_before = "voice_pack_before",
	start_timestamp = "start_timestamp",
	result_message = "result_message",
	result = "result",
	download_voice_pack_list = "download_voice_pack_list",
	entrance = "entrance",
	main_hero_interaction_area_id = "area_id",
	gamescene = "gamescene",
	main_hero_interaction_skin_id = "skinid",
	UpdatePercentage = "update_percentage",
	request_result = "request_result",
	resource_type = "resource_type",
	currenthost = "currenthost",
	current_voice_pack_used = "current_voice_pack_used",
	result_msg = "result_msg",
	voice_pack_delete = "voice_pack_delete",
	switchcount = "switchcount",
	result_code = "result_code",
	notice_id = "notice_id",
	request_url = "request_url",
	current_voice_pack_list = "current_voice_pack_list",
	step = "step"
}
slot0.RequestResult = {
	success = "success",
	fail = "fail"
}
slot0.Result = {
	success = "success",
	fail = "fail"
}
slot0.UserProperties = {
	FirstStartTime = "frist_star_time",
	DownloadChannel = "DownloadChannel",
	AppChannelId = "app_channelid",
	AppSubChannelId = "app_subchannelid"
}
slot0.PropertyTypes = {
	[slot0.EventProperties.notice_id] = "number",
	[slot0.EventProperties.notice_jump_id] = "number",
	[slot0.EventProperties.UpdateAmount] = "number",
	[slot0.EventProperties.UpdatePercentage] = "string",
	[slot0.UserProperties.DownloadChannel] = "string",
	[slot0.UserProperties.AppChannelId] = "string",
	[slot0.UserProperties.AppSubChannelId] = "string",
	[slot0.UserProperties.AppSubChannelId] = "string",
	[slot0.EventProperties.request_result] = "string",
	[slot0.EventProperties.request_url] = "string",
	[slot0.EventProperties.result_code] = "string",
	[slot0.EventProperties.result_message] = "string",
	[slot0.EventProperties.start_timestamp] = "datetime",
	[slot0.EventProperties.spend_time] = "number",
	[slot0.EventProperties.data_length] = "number",
	[slot0.EventProperties.host_ip] = "string",
	[slot0.EventProperties.result] = "string",
	[slot0.EventProperties.result_msg] = "string",
	[slot0.EventProperties.current_language] = "string",
	[slot0.EventProperties.entrance] = "string",
	[slot0.EventProperties.current_voice_pack_list] = "list",
	[slot0.EventProperties.current_voice_pack_used] = "string",
	[slot0.EventProperties.download_voice_pack_list] = "list",
	[slot0.EventProperties.update_amount] = "number",
	[slot0.EventProperties.step] = "string",
	[slot0.EventProperties.voice_pack_before] = "string",
	[slot0.EventProperties.voice_pack_delete] = "string",
	[slot0.EventProperties.gamescene] = "string",
	[slot0.EventProperties.currenthost] = "string",
	[slot0.EventProperties.switchcount] = "number",
	[slot0.EventProperties.resource_type] = "list",
	[slot0.EventProperties.main_hero_interaction_skin_id] = "number",
	[slot0.EventProperties.main_hero_interaction_area_id] = "number",
	[slot0.EventProperties.main_hero_interaction_voice_id] = "string"
}
slot0.DefinedTypeToLuaType = {
	string = "string",
	array = "table",
	datetime = "number",
	boolean = "boolean",
	list = "table",
	number = "number"
}
slot0.FirstStartTimePrefsKey = "DataTrackFirstStartTime"
slot0.MediaEvent = {
	purchase_firstGachaPack = "purchase_firstGacha20Pack",
	chapter_progress_3 = "chapter_progress_3",
	plot_progress_3_15 = "plot_progress_3_15",
	plot_progress_1_1 = "plot_progress_1_1",
	purchase = "purchase",
	roleLevel_15_achieve = "roleLevel_15_achieve",
	purchase_mothlyCard = "purchase_mothlyCard",
	purchase_bp_small = "purchase_bp_small",
	plot_progress_3_14 = "plot_progress_3_14",
	purchase_firstResourcePack = "purchase_firstResourcePack",
	game_summon_01 = "game_summon_01",
	purchase_level10pack = "purchase_level10pack",
	chapter_progress_1 = "chapter_progress_1",
	purchase_level5pack = "purchase_level5pack",
	plot_progress_1_4 = "plot_progress_1_4",
	first_purchase = "first_purchase",
	game_source_completed = "game_source_completed",
	purchase_bp_large = "purchase_bp_large",
	purchase_firstChargePack = "purchase_firstChargePack",
	roleLevel_10_achieve = "roleLevel_10_achieve",
	chapter_progress_2 = "chapter_progress_2",
	roleLevel_20_achieve = "roleLevel_20_achieve",
	purchase_skin = "purchase_skin",
	first_story_skip = "first_story_skip",
	roleLevel_5_achieve = "roleLevel_5_achieve",
	purchase_monthlyGachaPack = "purchase_monthlyGachaPack"
}
slot0.ChannelEvent = {
	stdhour1 = "stdhour1",
	stdrecharge = "stdrecharge",
	stdmonthly = "stdmonthly",
	stdrechargeprompt = "stdrechargeprompt",
	stdstaminapurchase = "stdstaminapurchase",
	stdhour3 = "stdhour3",
	stdlevel = "stdlevel",
	stdexhausted = "stdexhausted",
	stdlackofdiamonds = "stdlackofdiamonds"
}

function slot0.ctor(slot0)
	slot0.csharpInst = ZProj.SDKDataTrackManager.Instance
end

function slot0.initSDKDataTrack(slot0)
	slot0.csharpInst:InitSDKDataTrack()
	slot0:_setFirstStartTimeProperty()
end

function slot0.getDataTrackProperties(slot0)
	if not slot0:isEnableDataTrack() then
		return ""
	end

	return slot0.csharpInst:CallGetStrFunc("getDataTrackProperties")
end

function slot0.roleLogin(slot0, slot1)
	if not slot0:isEnableDataTrack() then
		return
	end

	slot0.csharpInst:CallVoidFuncWithParams("roleLogin", tostring(slot1))
	slot0:profileSet({
		[uv0.UserProperties.AppChannelId] = tostring(SDKMgr.instance:getChannelId()),
		[uv0.UserProperties.AppSubChannelId] = tostring(SDKMgr.instance:getSubChannelId())
	})
end

function slot0.track(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in pairs(slot2 or {}) do
		if not string.nilorempty(uv0.PropertyTypes[slot7]) and type(slot8) ~= uv0.DefinedTypeToLuaType[slot9] then
			logError(string.format("埋点 属性类型不一致, propertyName: %s, param: %s, currentType: %s, definedType: %s", tostring(slot7), tostring(slot8), type(slot8), uv0.DefinedTypeToLuaType[slot9]))
		end

		if slot9 == "array" or slot9 == "list" and JsonUtil then
			JsonUtil.markAsArray(slot8)
		end

		if slot9 == "array" and #slot8 <= 0 then
			table.insert(slot3, slot7)
		end
	end

	for slot7, slot8 in ipairs(slot3) do
		slot2[slot8] = nil
	end

	if isDebugBuild then
		logNormal("track event : eventName : " .. slot1 .. ", properties : " .. cjson.encode(slot2))
	end

	if not slot0:isEnableDataTrack() then
		return
	end

	return slot0.csharpInst:CallVoidFuncWithParams("track", slot1, slot0:_tableToDictionary(slot2))
end

function slot0.trackMediaEvent(slot0, slot1)
	if not slot0:isEnableDataTrack() then
		return
	end

	if not GameChannelConfig.isGpGlobal() and not GameChannelConfig.isGpJapan() then
		return
	end

	return slot0.csharpInst:CallVoidFuncWithParams("trackMediaEvent", cjson.encode({
		eventName = slot1
	}))
end

function slot0.trackMediaPayEvent(slot0, slot1, slot2)
	if not slot0:isEnableDataTrack() then
		return
	end

	if not GameChannelConfig.isGpGlobal() and not GameChannelConfig.isGpJapan() then
		return
	end

	return slot0.csharpInst:CallVoidFuncWithParams("trackMediaPayEvent", cjson.encode({
		eventName = slot1,
		amount = slot2.amount,
		currency = slot2.currency,
		productId = slot2.productId,
		goodsName = slot2.goodsName,
		goodsId = slot2.goodsId
	}))
end

function slot0.trackChannelEvent(slot0, slot1)
	if not slot0:isEnableDataTrack() then
		return
	end

	return slot0.csharpInst:CallVoidFuncWithParams("trackChannelEvent", cjson.encode({
		eventName = slot1
	}))
end

function slot0.profileSet(slot0, slot1)
	if not slot0:isEnableDataTrack() then
		return
	end

	return slot0.csharpInst:CallVoidFuncWithParams("profileSet", slot0:_tableToDictionary(slot1))
end

function slot0.isEnableDataTrack(slot0)
	return not SLFramework.FrameworkSettings.IsEditor and not GameChannelConfig.isSlsdk()
end

function slot0._setFirstStartTimeProperty(slot0)
	if UnityEngine.PlayerPrefs.GetInt(uv0.FirstStartTimePrefsKey, 0) == 0 then
		slot1 = os.time()

		UnityEngine.PlayerPrefs.SetInt(uv0.FirstStartTimePrefsKey, slot1)

		slot3 = os.date("%Y-%m-%d %H:%M:%S", slot1)

		slot0:profileSet({
			[uv0.UserProperties.DownloadChannel] = tostring(SDKMgr.instance:getSubChannelId())
		})
	end
end

function slot0.trackChooseServerEvent(slot0)
	uv0.instance:track(uv0.EventName.ChooseServer, {})
end

function slot0.trackHotupdateFilesCheckEvent(slot0, slot1, slot2)
	if slot1 == uv0.Result.fail then
		uv0.instance:track(uv0.EventName.hotupdate_files_check_fail, {
			[uv0.EventProperties.result_msg] = slot2 or ""
		})
	else
		uv0.instance:track(uv0.EventName.hotupdate_files_check, {})
	end
end

function slot0.trackUnzipFinishEvent(slot0, slot1, slot2)
	if slot1 == uv0.Result.fail then
		uv0.instance:track(uv0.EventName.unzip_finish_fail, {
			[uv0.EventProperties.result_msg] = slot2 or ""
		})
	else
		uv0.instance:track(uv0.EventName.unzip_finish, {})
	end
end

function slot0.trackResourceLoadFinishEvent(slot0, slot1, slot2)
	if slot1 == uv0.Result.fail then
		uv0.instance:track(uv0.EventName.resource_load_fail, {
			[uv0.EventProperties.result_msg] = slot2 or ""
		})
	else
		uv0.instance:track(uv0.EventName.resource_load_finish, {})
	end
end

function slot0.trackGetRemoteVersionEvent(slot0, slot1, slot2, slot3, slot4)
	uv0.instance:track(uv0.EventName.hotupdate_request, {
		[uv0.EventProperties.request_result] = slot1,
		[uv0.EventProperties.request_url] = slot2,
		[uv0.EventProperties.result_code] = slot3 and tostring(slot3) or "",
		[uv0.EventProperties.result_message] = slot4 or ""
	})
end

function slot0.trackHotUpdateResourceEvent(slot0, slot1, slot2, slot3, slot4)
	uv0.instance:track(uv0.EventName.hotupdate_request_resource, {
		[uv0.EventProperties.request_result] = slot1,
		[uv0.EventProperties.request_url] = slot2,
		[uv0.EventProperties.result_code] = slot3 and tostring(slot3) or "",
		[uv0.EventProperties.result_message] = slot4 or ""
	})
end

function slot0.trackSocketConnectEvent(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1 == uv0.RequestResult.success then
		uv0.instance:track(uv0.EventName.first_socket_connect)
	end

	uv0.instance:track(uv0.EventName.socket_connect, {
		[uv0.EventProperties.request_result] = slot1,
		[uv0.EventProperties.start_timestamp] = slot2,
		[uv0.EventProperties.spend_time] = slot3,
		[uv0.EventProperties.data_length] = slot4,
		[uv0.EventProperties.host_ip] = slot5
	})
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

function slot0.trackOptionPackDownloading(slot0, slot1)
	uv0.instance:track(uv0.EventName.resources_downloading, {
		[uv0.EventProperties.step] = slot1.step,
		[uv0.EventProperties.resource_type] = slot1.resource_type or "",
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

function slot0.trackDomainFailCount(slot0, slot1, slot2, slot3)
	if slot3 > 0 then
		uv0.instance:track(uv0.EventName.event_hostswitch, {
			[uv0.EventProperties.gamescene] = slot1,
			[uv0.EventProperties.currenthost] = slot2,
			[uv0.EventProperties.switchcount] = slot3
		})
	end
end

function slot0.trackMainHeroInteraction(slot0, slot1)
	uv0.instance:track(uv0.EventName.main_hero_interaction, {
		[uv0.EventProperties.main_hero_interaction_skin_id] = slot1.main_hero_interaction_skin_id or -1,
		[uv0.EventProperties.main_hero_interaction_area_id] = slot1.main_hero_interaction_area_id or -1,
		[uv0.EventProperties.main_hero_interaction_voice_id] = slot1.main_hero_interaction_voice_id or ""
	})
end

function slot0._tableToDictionary(slot0, slot1)
	slot2 = nil

	return slot0.csharpInst:ConvertDictionary((not JsonUtil or JsonUtil.encode(slot1)) and cjson.encode(slot1))
end

slot0.instance = slot0.New()

return slot0
