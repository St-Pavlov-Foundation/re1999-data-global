module("modules.logic.room.controller.RoomInformController", package.seeall)

slot0 = class("RoomInformController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onInitFinish(slot0)
end

slot0.SCREEN_CAPTURE_BLOCK_KEY = "RoomInformController.SCREEN_CAPTURE_BLOCK_KEY"

function slot0.openShareTipView(slot0, slot1, slot2)
	if slot0._viewOpenParams then
		return
	end

	UIBlockMgr.instance:startBlock(uv0.SCREEN_CAPTURE_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(false)

	slot0._viewOpenParams = {
		playerMO = slot1,
		shareCode = slot2
	}

	if GameSceneMgr.instance:getCurScene() and slot3.camera and slot3.camera:getCameraState() ~= RoomEnum.CameraState.OverlookAll then
		slot3.camera:switchCameraState(RoomEnum.CameraState.OverlookAll, {
			zoom = 1
		}, nil, slot0._screenCapture, slot0)
	else
		slot0:_screenCapture()
	end
end

function slot0._screenCapture(slot0)
	ZProj.ScreenCaptureUtil.Instance:ReadScreenPixelsAsTexture(nil, slot0._onOpenInformView, slot0)
end

function slot0._onOpenInformView(slot0, slot1)
	UIBlockMgr.instance:endBlock(uv0.SCREEN_CAPTURE_BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(true)

	slot0._viewOpenParams = nil
	slot0._viewOpenParams.texture2d = slot1
	slot3 = {}

	if not string.nilorempty(CommonConfig.instance:getConstStr(ConstEnum.RoomInformTypeTitles)) then
		for slot9, slot10 in ipairs(string.split(slot4, "#") or {}) do
			table.insert(slot3, {
				id = slot9,
				desc = slot10
			})
		end
	end

	RoomReportTypeListModel.instance:initType(slot3)
	ViewMgr.instance:openView(ViewName.RoomInformPlayerView, slot2)
end

slot0.SEND_REPORT_ROOM_BLOCK_KEY = "RoomInformController.SEND_REPORT_ROOM_BLOCK_KEY"

function slot0.sendReportRoom(slot0, slot1, slot2, slot3, slot4)
	UIBlockMgr.instance:startBlock(uv0.SEND_REPORT_ROOM_BLOCK_KEY)
	RoomRpc.instance:sendReportRoomRequest(slot1, slot2, slot3, slot4, slot0._onReportRoomReply, slot0)
end

function slot0._onReportRoomReply(slot0, slot1, slot2, slot3)
	UIBlockMgr.instance:endBlock(uv0.SEND_REPORT_ROOM_BLOCK_KEY)

	if slot2 == 0 then
		RoomController.instance:dispatchEvent(RoomEvent.InformSuccessReply, slot3.token)
	end
end

function slot0.uploadImage(slot0, slot1, slot2)
	slot5 = string.format("%s/%s", slot0:getHttpLoginUrl(), "roomreportpicture")
	slot7 = UnityEngine.WWWForm.New()

	slot7:AddField("token", slot2)
	slot7:AddBinaryData("fileData", UnityEngine.ImageConversion.EncodeToJPG(slot1, 25))
	SLFramework.SLWebRequest.Instance:PostWWWForm(slot5, slot7, nil, slot0._onUploadImageResponse, slot0)
	logNormal(slot5)
end

function slot0._onUploadImageResponse(slot0, slot1, slot2)
	if not slot1 or string.nilorempty(slot2) then
		logNormal(string.format("上传图片失败"))
	else
		logNormal(slot2)
	end
end

function slot0.getHttpLoginUrl(slot0)
	slot1 = nil

	if type(UrlConfig.getConfig().login) == "table" then
		if not slot2[tostring(SDKMgr.instance:getChannelId()) or "100"] then
			for slot7, slot8 in pairs(slot2) do
				logError(string.format("httpLoginUrl not exist, channelId=%s\nuse %s:%s", slot3, slot7, slot8 or "nil"))

				break
			end
		end
	else
		slot1 = slot2
	end

	return slot1
end

function slot0._saveImage(slot0, slot1)
	slot3 = System.DateTime.Now
	slot5 = System.IO.Path.Combine(System.IO.Path.Combine(UnityEngine.Application.persistentDataPath, "screenshot"), string.format("room_screenshot_%s%s%s_%s%s%s%s.jpg", slot3.Year, slot3.Month, slot3.Day, slot3.Hour, slot3.Minute, slot3.Second, slot3.Millisecond))

	SLFramework.FileHelper.WriteAllBytesToPath(slot5, slot1)

	return slot5
end

slot0.instance = slot0.New()

return slot0
