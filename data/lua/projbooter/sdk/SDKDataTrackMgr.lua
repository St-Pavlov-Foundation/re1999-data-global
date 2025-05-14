module("projbooter.sdk.SDKDataTrackMgr", package.seeall)

local var_0_0 = class("SDKDataTrackMgr")

function var_0_0.trackNoticeLoad(arg_1_0, arg_1_1)
	var_0_0.instance:track(var_0_0.EventName.notice_load, {
		[var_0_0.EventProperties.notice_id] = arg_1_1.notice_id or -1
	})
end

function var_0_0.trackNoticeJump(arg_2_0, arg_2_1)
	var_0_0.instance:track(var_0_0.EventName.notice_jump, {
		[var_0_0.EventProperties.notice_id] = arg_2_1.notice_id or -1,
		[var_0_0.EventProperties.notice_jump_id] = arg_2_1.notice_jump_id or -1
	})
end

var_0_0.EventName = {
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
var_0_0.EventProperties = {
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
var_0_0.RequestResult = {
	success = "success",
	fail = "fail"
}
var_0_0.Result = {
	success = "success",
	fail = "fail"
}
var_0_0.UserProperties = {
	FirstStartTime = "frist_star_time",
	DownloadChannel = "DownloadChannel",
	AppChannelId = "app_channelid",
	AppSubChannelId = "app_subchannelid"
}
var_0_0.PropertyTypes = {
	[var_0_0.EventProperties.notice_id] = "number",
	[var_0_0.EventProperties.notice_jump_id] = "number",
	[var_0_0.EventProperties.UpdateAmount] = "number",
	[var_0_0.EventProperties.UpdatePercentage] = "string",
	[var_0_0.UserProperties.DownloadChannel] = "string",
	[var_0_0.UserProperties.AppChannelId] = "string",
	[var_0_0.UserProperties.AppSubChannelId] = "string",
	[var_0_0.UserProperties.AppSubChannelId] = "string",
	[var_0_0.EventProperties.request_result] = "string",
	[var_0_0.EventProperties.request_url] = "string",
	[var_0_0.EventProperties.result_code] = "string",
	[var_0_0.EventProperties.result_message] = "string",
	[var_0_0.EventProperties.start_timestamp] = "datetime",
	[var_0_0.EventProperties.spend_time] = "number",
	[var_0_0.EventProperties.data_length] = "number",
	[var_0_0.EventProperties.host_ip] = "string",
	[var_0_0.EventProperties.result] = "string",
	[var_0_0.EventProperties.result_msg] = "string",
	[var_0_0.EventProperties.current_language] = "string",
	[var_0_0.EventProperties.entrance] = "string",
	[var_0_0.EventProperties.current_voice_pack_list] = "list",
	[var_0_0.EventProperties.current_voice_pack_used] = "string",
	[var_0_0.EventProperties.download_voice_pack_list] = "list",
	[var_0_0.EventProperties.update_amount] = "number",
	[var_0_0.EventProperties.step] = "string",
	[var_0_0.EventProperties.voice_pack_before] = "string",
	[var_0_0.EventProperties.voice_pack_delete] = "string",
	[var_0_0.EventProperties.gamescene] = "string",
	[var_0_0.EventProperties.currenthost] = "string",
	[var_0_0.EventProperties.switchcount] = "number",
	[var_0_0.EventProperties.resource_type] = "list",
	[var_0_0.EventProperties.main_hero_interaction_skin_id] = "number",
	[var_0_0.EventProperties.main_hero_interaction_area_id] = "number",
	[var_0_0.EventProperties.main_hero_interaction_voice_id] = "string"
}
var_0_0.DefinedTypeToLuaType = {
	string = "string",
	array = "table",
	datetime = "number",
	boolean = "boolean",
	list = "table",
	number = "number"
}
var_0_0.FirstStartTimePrefsKey = "DataTrackFirstStartTime"
var_0_0.MediaEvent = {
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
var_0_0.ChannelEvent = {
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

function var_0_0.ctor(arg_3_0)
	arg_3_0.csharpInst = ZProj.SDKDataTrackManager.Instance
end

function var_0_0.initSDKDataTrack(arg_4_0)
	arg_4_0.csharpInst:InitSDKDataTrack()
	arg_4_0:_setFirstStartTimeProperty()
end

function var_0_0.getDataTrackProperties(arg_5_0)
	if not arg_5_0:isEnableDataTrack() then
		return ""
	end

	return arg_5_0.csharpInst:CallGetStrFunc("getDataTrackProperties")
end

function var_0_0.roleLogin(arg_6_0, arg_6_1)
	if not arg_6_0:isEnableDataTrack() then
		return
	end

	arg_6_0.csharpInst:CallVoidFuncWithParams("roleLogin", tostring(arg_6_1))

	local var_6_0 = tostring(SDKMgr.instance:getChannelId())
	local var_6_1 = tostring(SDKMgr.instance:getSubChannelId())

	arg_6_0:profileSet({
		[var_0_0.UserProperties.AppChannelId] = var_6_0,
		[var_0_0.UserProperties.AppSubChannelId] = var_6_1
	})
end

function var_0_0.track(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {}

	arg_7_2 = arg_7_2 or {}

	for iter_7_0, iter_7_1 in pairs(arg_7_2) do
		local var_7_1 = var_0_0.PropertyTypes[iter_7_0]

		if not string.nilorempty(var_7_1) and type(iter_7_1) ~= var_0_0.DefinedTypeToLuaType[var_7_1] then
			logError(string.format("埋点 属性类型不一致, propertyName: %s, param: %s, currentType: %s, definedType: %s", tostring(iter_7_0), tostring(iter_7_1), type(iter_7_1), var_0_0.DefinedTypeToLuaType[var_7_1]))
		end

		if var_7_1 == "array" or var_7_1 == "list" and JsonUtil then
			JsonUtil.markAsArray(iter_7_1)
		end

		if var_7_1 == "array" and #iter_7_1 <= 0 then
			table.insert(var_7_0, iter_7_0)
		end
	end

	for iter_7_2, iter_7_3 in ipairs(var_7_0) do
		arg_7_2[iter_7_3] = nil
	end

	if isDebugBuild then
		logNormal("track event : eventName : " .. arg_7_1 .. ", properties : " .. cjson.encode(arg_7_2))
	end

	if not arg_7_0:isEnableDataTrack() then
		return
	end

	return arg_7_0.csharpInst:CallVoidFuncWithParams("track", arg_7_1, arg_7_0:_tableToDictionary(arg_7_2))
end

function var_0_0.trackMediaEvent(arg_8_0, arg_8_1)
	if not arg_8_0:isEnableDataTrack() then
		return
	end

	if not GameChannelConfig.isGpGlobal() and not GameChannelConfig.isGpJapan() then
		return
	end

	local var_8_0 = {
		eventName = arg_8_1
	}
	local var_8_1 = cjson.encode(var_8_0)

	return arg_8_0.csharpInst:CallVoidFuncWithParams("trackMediaEvent", var_8_1)
end

function var_0_0.trackMediaPayEvent(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0:isEnableDataTrack() then
		return
	end

	if not GameChannelConfig.isGpGlobal() and not GameChannelConfig.isGpJapan() then
		return
	end

	local var_9_0 = {
		eventName = arg_9_1,
		amount = arg_9_2.amount,
		currency = arg_9_2.currency,
		productId = arg_9_2.productId,
		goodsName = arg_9_2.goodsName,
		goodsId = arg_9_2.goodsId
	}
	local var_9_1 = cjson.encode(var_9_0)

	return arg_9_0.csharpInst:CallVoidFuncWithParams("trackMediaPayEvent", var_9_1)
end

function var_0_0.trackChannelEvent(arg_10_0, arg_10_1)
	if not arg_10_0:isEnableDataTrack() then
		return
	end

	local var_10_0 = {
		eventName = arg_10_1
	}
	local var_10_1 = cjson.encode(var_10_0)

	return arg_10_0.csharpInst:CallVoidFuncWithParams("trackChannelEvent", var_10_1)
end

function var_0_0.profileSet(arg_11_0, arg_11_1)
	if not arg_11_0:isEnableDataTrack() then
		return
	end

	return arg_11_0.csharpInst:CallVoidFuncWithParams("profileSet", arg_11_0:_tableToDictionary(arg_11_1))
end

function var_0_0.isEnableDataTrack(arg_12_0)
	return not SLFramework.FrameworkSettings.IsEditor and not GameChannelConfig.isSlsdk()
end

function var_0_0._setFirstStartTimeProperty(arg_13_0)
	local var_13_0 = UnityEngine.PlayerPrefs.GetInt(var_0_0.FirstStartTimePrefsKey, 0)
	local var_13_1 = tostring(SDKMgr.instance:getSubChannelId())

	if var_13_0 == 0 then
		local var_13_2 = os.time()

		UnityEngine.PlayerPrefs.SetInt(var_0_0.FirstStartTimePrefsKey, var_13_2)

		local var_13_3 = os.date("%Y-%m-%d %H:%M:%S", var_13_2)

		arg_13_0:profileSet({
			[var_0_0.UserProperties.DownloadChannel] = var_13_1
		})
	end
end

function var_0_0.trackChooseServerEvent(arg_14_0)
	var_0_0.instance:track(var_0_0.EventName.ChooseServer, {})
end

function var_0_0.trackHotupdateFilesCheckEvent(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == var_0_0.Result.fail then
		var_0_0.instance:track(var_0_0.EventName.hotupdate_files_check_fail, {
			[var_0_0.EventProperties.result_msg] = arg_15_2 or ""
		})
	else
		var_0_0.instance:track(var_0_0.EventName.hotupdate_files_check, {})
	end
end

function var_0_0.trackUnzipFinishEvent(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == var_0_0.Result.fail then
		var_0_0.instance:track(var_0_0.EventName.unzip_finish_fail, {
			[var_0_0.EventProperties.result_msg] = arg_16_2 or ""
		})
	else
		var_0_0.instance:track(var_0_0.EventName.unzip_finish, {})
	end
end

function var_0_0.trackResourceLoadFinishEvent(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == var_0_0.Result.fail then
		var_0_0.instance:track(var_0_0.EventName.resource_load_fail, {
			[var_0_0.EventProperties.result_msg] = arg_17_2 or ""
		})
	else
		var_0_0.instance:track(var_0_0.EventName.resource_load_finish, {})
	end
end

function var_0_0.trackGetRemoteVersionEvent(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	arg_18_3 = arg_18_3 and tostring(arg_18_3)

	var_0_0.instance:track(var_0_0.EventName.hotupdate_request, {
		[var_0_0.EventProperties.request_result] = arg_18_1,
		[var_0_0.EventProperties.request_url] = arg_18_2,
		[var_0_0.EventProperties.result_code] = arg_18_3 or "",
		[var_0_0.EventProperties.result_message] = arg_18_4 or ""
	})
end

function var_0_0.trackHotUpdateResourceEvent(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	arg_19_3 = arg_19_3 and tostring(arg_19_3)

	var_0_0.instance:track(var_0_0.EventName.hotupdate_request_resource, {
		[var_0_0.EventProperties.request_result] = arg_19_1,
		[var_0_0.EventProperties.request_url] = arg_19_2,
		[var_0_0.EventProperties.result_code] = arg_19_3 or "",
		[var_0_0.EventProperties.result_message] = arg_19_4 or ""
	})
end

function var_0_0.trackSocketConnectEvent(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	if arg_20_1 == var_0_0.RequestResult.success then
		var_0_0.instance:track(var_0_0.EventName.first_socket_connect)
	end

	var_0_0.instance:track(var_0_0.EventName.socket_connect, {
		[var_0_0.EventProperties.request_result] = arg_20_1,
		[var_0_0.EventProperties.start_timestamp] = arg_20_2,
		[var_0_0.EventProperties.spend_time] = arg_20_3,
		[var_0_0.EventProperties.data_length] = arg_20_4,
		[var_0_0.EventProperties.host_ip] = arg_20_5
	})
end

function var_0_0.trackVoicePackDownloadConfirm(arg_21_0, arg_21_1)
	var_0_0.instance:track(var_0_0.EventName.voice_pack_download_confirm, {
		[var_0_0.EventProperties.current_language] = GameConfig:GetCurLangShortcut(),
		[var_0_0.EventProperties.current_voice_pack_used] = GameConfig:GetCurVoiceShortcut(),
		[var_0_0.EventProperties.current_voice_pack_list] = arg_21_1.current_voice_pack_list or {},
		[var_0_0.EventProperties.download_voice_pack_list] = arg_21_1.download_voice_pack_list or {},
		[var_0_0.EventProperties.entrance] = arg_21_1.entrance,
		[var_0_0.EventProperties.update_amount] = arg_21_1.update_amount or 0
	})
end

function var_0_0.trackVoicePackDownloading(arg_22_0, arg_22_1)
	var_0_0.instance:track(var_0_0.EventName.voice_pack_downloading, {
		[var_0_0.EventProperties.step] = arg_22_1.step,
		[var_0_0.EventProperties.download_voice_pack_list] = arg_22_1.download_voice_pack_list or {},
		[var_0_0.EventProperties.update_amount] = arg_22_1.update_amount or 0,
		[var_0_0.EventProperties.spend_time] = arg_22_1.spend_time or 0,
		[var_0_0.EventProperties.result_msg] = arg_22_1.result_msg or ""
	})
end

function var_0_0.trackOptionPackDownloading(arg_23_0, arg_23_1)
	var_0_0.instance:track(var_0_0.EventName.resources_downloading, {
		[var_0_0.EventProperties.step] = arg_23_1.step,
		[var_0_0.EventProperties.resource_type] = arg_23_1.resource_type or "",
		[var_0_0.EventProperties.update_amount] = arg_23_1.update_amount or 0,
		[var_0_0.EventProperties.spend_time] = arg_23_1.spend_time or 0,
		[var_0_0.EventProperties.result_msg] = arg_23_1.result_msg or ""
	})
end

function var_0_0.trackOptionPackConfirmDownload(arg_24_0, arg_24_1)
	var_0_0.instance:track(var_0_0.EventName.confirm_download_resources, {
		[var_0_0.EventProperties.resource_type] = arg_24_1.resource_type or {}
	})
end

function var_0_0.trackVoicePackSwitch(arg_25_0, arg_25_1)
	var_0_0.instance:track(var_0_0.EventName.voice_pack_switch, {
		[var_0_0.EventProperties.current_language] = arg_25_1.current_language,
		[var_0_0.EventProperties.entrance] = arg_25_1.entrance or "",
		[var_0_0.EventProperties.current_voice_pack_list] = arg_25_1.current_voice_pack_list or {},
		[var_0_0.EventProperties.current_voice_pack_used] = arg_25_1.current_voice_pack_used or "",
		[var_0_0.EventProperties.voice_pack_before] = arg_25_1.voice_pack_before or ""
	})
end

function var_0_0.trackVoicePackDelete(arg_26_0, arg_26_1)
	var_0_0.instance:track(var_0_0.EventName.voice_pack_delete, {
		[var_0_0.EventProperties.current_language] = arg_26_1.current_language,
		[var_0_0.EventProperties.current_voice_pack_list] = arg_26_1.current_voice_pack_list or {},
		[var_0_0.EventProperties.current_voice_pack_used] = arg_26_1.current_voice_pack_used or "",
		[var_0_0.EventProperties.voice_pack_delete] = arg_26_1.voice_pack_delete or ""
	})
end

function var_0_0.trackDomainFailCount(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	if arg_27_3 > 0 then
		var_0_0.instance:track(var_0_0.EventName.event_hostswitch, {
			[var_0_0.EventProperties.gamescene] = arg_27_1,
			[var_0_0.EventProperties.currenthost] = arg_27_2,
			[var_0_0.EventProperties.switchcount] = arg_27_3
		})
	end
end

function var_0_0.trackMainHeroInteraction(arg_28_0, arg_28_1)
	var_0_0.instance:track(var_0_0.EventName.main_hero_interaction, {
		[var_0_0.EventProperties.main_hero_interaction_skin_id] = arg_28_1.main_hero_interaction_skin_id or -1,
		[var_0_0.EventProperties.main_hero_interaction_area_id] = arg_28_1.main_hero_interaction_area_id or -1,
		[var_0_0.EventProperties.main_hero_interaction_voice_id] = arg_28_1.main_hero_interaction_voice_id or ""
	})
end

function var_0_0._tableToDictionary(arg_29_0, arg_29_1)
	local var_29_0

	if JsonUtil then
		var_29_0 = JsonUtil.encode(arg_29_1)
	else
		var_29_0 = cjson.encode(arg_29_1)
	end

	return arg_29_0.csharpInst:ConvertDictionary(var_29_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
