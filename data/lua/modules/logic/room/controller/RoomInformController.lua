module("modules.logic.room.controller.RoomInformController", package.seeall)

local var_0_0 = class("RoomInformController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

var_0_0.SCREEN_CAPTURE_BLOCK_KEY = "RoomInformController.SCREEN_CAPTURE_BLOCK_KEY"

function var_0_0.openShareTipView(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._viewOpenParams then
		return
	end

	UIBlockMgr.instance:startBlock(var_0_0.SCREEN_CAPTURE_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(false)

	arg_4_0._viewOpenParams = {
		playerMO = arg_4_1,
		shareCode = arg_4_2
	}

	local var_4_0 = GameSceneMgr.instance:getCurScene()

	if var_4_0 and var_4_0.camera and var_4_0.camera:getCameraState() ~= RoomEnum.CameraState.OverlookAll then
		var_4_0.camera:switchCameraState(RoomEnum.CameraState.OverlookAll, {
			zoom = 1
		}, nil, arg_4_0._screenCapture, arg_4_0)
	else
		arg_4_0:_screenCapture()
	end
end

function var_0_0._screenCapture(arg_5_0)
	ZProj.ScreenCaptureUtil.Instance:ReadScreenPixelsAsTexture(nil, arg_5_0._onOpenInformView, arg_5_0)
end

function var_0_0._onOpenInformView(arg_6_0, arg_6_1)
	UIBlockMgr.instance:endBlock(var_0_0.SCREEN_CAPTURE_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(true)

	local var_6_0 = arg_6_0._viewOpenParams

	arg_6_0._viewOpenParams = nil
	var_6_0.texture2d = arg_6_1

	local var_6_1 = {}
	local var_6_2 = CommonConfig.instance:getConstStr(ConstEnum.RoomInformTypeTitles)

	if not string.nilorempty(var_6_2) then
		local var_6_3 = string.split(var_6_2, "#") or {}

		for iter_6_0, iter_6_1 in ipairs(var_6_3) do
			table.insert(var_6_1, {
				id = iter_6_0,
				desc = iter_6_1
			})
		end
	end

	RoomReportTypeListModel.instance:initType(var_6_1)
	ViewMgr.instance:openView(ViewName.RoomInformPlayerView, var_6_0)
end

var_0_0.SEND_REPORT_ROOM_BLOCK_KEY = "RoomInformController.SEND_REPORT_ROOM_BLOCK_KEY"

function var_0_0.sendReportRoom(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	UIBlockMgr.instance:startBlock(var_0_0.SEND_REPORT_ROOM_BLOCK_KEY)
	RoomRpc.instance:sendReportRoomRequest(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_0._onReportRoomReply, arg_7_0)
end

function var_0_0._onReportRoomReply(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	UIBlockMgr.instance:endBlock(var_0_0.SEND_REPORT_ROOM_BLOCK_KEY)

	if arg_8_2 == 0 then
		RoomController.instance:dispatchEvent(RoomEvent.InformSuccessReply, arg_8_3.token)
	end
end

function var_0_0.uploadImage(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = UnityEngine.ImageConversion.EncodeToJPG(arg_9_1, 25)
	local var_9_1 = arg_9_0:getHttpLoginUrl()
	local var_9_2 = string.format("%s/%s", var_9_1, "roomreportpicture")
	local var_9_3
	local var_9_4 = UnityEngine.WWWForm.New()

	var_9_4:AddField("token", arg_9_2)
	var_9_4:AddBinaryData("fileData", var_9_0)
	SLFramework.SLWebRequest.Instance:PostWWWForm(var_9_2, var_9_4, var_9_3, arg_9_0._onUploadImageResponse, arg_9_0)
	logNormal(var_9_2)
end

function var_0_0._onUploadImageResponse(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 or string.nilorempty(arg_10_2) then
		logNormal(string.format("上传图片失败"))
	else
		logNormal(arg_10_2)
	end
end

function var_0_0.getHttpLoginUrl(arg_11_0)
	local var_11_0
	local var_11_1 = UrlConfig.getConfig().login

	if type(var_11_1) == "table" then
		local var_11_2 = tostring(SDKMgr.instance:getChannelId()) or "100"

		var_11_0 = var_11_1[var_11_2]

		if not var_11_0 then
			for iter_11_0, iter_11_1 in pairs(var_11_1) do
				var_11_0 = iter_11_1

				logError(string.format("httpLoginUrl not exist, channelId=%s\nuse %s:%s", var_11_2, iter_11_0, var_11_0 or "nil"))

				break
			end
		end
	else
		var_11_0 = var_11_1
	end

	return var_11_0
end

function var_0_0._saveImage(arg_12_0, arg_12_1)
	local var_12_0 = System.IO.Path.Combine(UnityEngine.Application.persistentDataPath, "screenshot")
	local var_12_1 = System.DateTime.Now
	local var_12_2 = string.format("room_screenshot_%s%s%s_%s%s%s%s.jpg", var_12_1.Year, var_12_1.Month, var_12_1.Day, var_12_1.Hour, var_12_1.Minute, var_12_1.Second, var_12_1.Millisecond)
	local var_12_3 = System.IO.Path.Combine(var_12_0, var_12_2)

	SLFramework.FileHelper.WriteAllBytesToPath(var_12_3, arg_12_1)

	return var_12_3
end

var_0_0.instance = var_0_0.New()

return var_0_0
