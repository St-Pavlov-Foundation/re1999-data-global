module("modules.logic.share.view.ShareEditorView", package.seeall)

slot0 = class("ShareEditorView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gorawImage = gohelper.findChild(slot0.viewGO, "container/frame/#go_rawImage")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "container/frame/#go_content")
	slot0._goplatformitem = gohelper.findChild(slot0.viewGO, "container/frame/#go_platformitem")
	slot0._togglehideview = gohelper.findChildToggle(slot0.viewGO, "container/frame/#toggle_hideview")
	slot0._simagelogo = gohelper.findChildSingleImage(slot0.viewGO, "#simage_logo")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._viewOpen = false

	gohelper.setActive(slot0._togglehideview.gameObject, false)

	slot1 = nil
	slot1 = (SDKMgr.instance:getChannelId() ~= SDKMgr.ChannelId.QQMobile or {
		"fenxiang_qq",
		"fenxiang_kongjian"
	}) and (SDKMgr.instance:getChannelId() ~= SDKMgr.ChannelId.Douyin or {
		"fenxiang_douyin"
	}) and {
		"fenxiang_weixin",
		"fenxiang_pengyouqvan",
		"fenxiang_weibo",
		"fenxiang_qq",
		"fenxiang_kongjian",
		"fenxiang_douyin",
		"fenxiang_xiaohongshu",
		"fenxiang_xiazai"
	}
	slot0._listenerList = slot0:getUserDataTb_()

	for slot5, slot6 in ipairs((not GameChannelConfig.isEfun() or {
		"fenxiang_facebook",
		"fenxiang_instagram",
		"fenxiang_line",
		"fenxiang_discord",
		"fenxiang_xiazai"
	}) and {
		"fenxiang_facebook",
		"fenxiang_twitter",
		"fenxiang_xiazai"
	}) do
		slot7 = gohelper.clone(slot0._goplatformitem, slot0._gocontent, slot6)

		gohelper.setActive(slot7, true)
		UISpriteSetMgr.instance:setShareSprite(slot7:GetComponent(gohelper.Type_Image), slot6)

		slot9 = SLFramework.UGUI.UIClickListener.Get(slot7)

		slot9:AddClickListener(slot0._onClick, slot0, slot6)
		table.insert(slot0._listenerList, slot9)
	end
end

function slot0._onClick(slot0, slot1)
	if not slot0._canClick then
		return
	end

	if string.nilorempty(slot0._msg) then
		logError("图片地址为空")

		return
	end

	logNormal(slot0._msg)

	if slot1 == "fenxiang_weixin" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.WechatFriend, SDKMgr.ShareContentType.Image, slot0._msg)
	elseif slot1 == "fenxiang_pengyouqvan" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.WechatMoment, SDKMgr.ShareContentType.Image, slot0._msg)
	elseif slot1 == "fenxiang_weibo" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.SinaWeibo, SDKMgr.ShareContentType.Image, slot0._msg)
	elseif slot1 == "fenxiang_douyin" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.TikTok, SDKMgr.ShareContentType.Image, slot0._msg)
	elseif slot1 == "fenxiang_xiaohongshu" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.XiaoHongShu, SDKMgr.ShareContentType.Image, slot0._msg)
	elseif slot1 == "fenxiang_qq" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.QQ, SDKMgr.ShareContentType.Image, slot0._msg)
	elseif slot1 == "fenxiang_kongjian" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.QQZone, SDKMgr.ShareContentType.Image, slot0._msg)
	elseif slot1 == "fenxiang_xiazai" then
		SDKMgr.instance:saveImage(slot0._msg)
	elseif slot1 == "fenxiang_facebook" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.Facebook, SDKMgr.ShareContentType.Image, slot0._msg)
	elseif slot1 == "fenxiang_twitter" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.Twitter, SDKMgr.ShareContentType.Image, slot0._msg)
	elseif slot1 == "fenxiang_line" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.LINE, SDKMgr.ShareContentType.Image, slot0._msg)
	elseif slot1 == "fenxiang_whatsapp" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.WHATSAPP, SDKMgr.ShareContentType.Image, slot0._msg)
	elseif slot1 == "fenxiang_instagram" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.INSTAGRAM, SDKMgr.ShareContentType.Image, slot0._msg)
	elseif slot1 == "fenxiang_discord" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.DISCORD, SDKMgr.ShareContentType.Image, slot0._msg)
	end
end

function slot0.onOpen(slot0)
	slot0._viewOpen = true
	slot0._canClick = false
	slot0._texture = slot0.viewParam
	slot0._image = gohelper.onceAddComponent(slot0._gorawImage, gohelper.Type_RawImage)
	slot0._image.texture = slot0._texture

	slot0._simagelogo:LoadImage(ResUrl.getLoginBgLangIcon("bg_logo"), slot0._logoLoaded, slot0)
	TaskDispatcher.runDelay(slot0._overTime, slot0, 1)
end

function slot0._overTime(slot0)
	slot0._canClick = true
end

function slot0._logoLoaded(slot0)
	if not slot0._viewOpen then
		return
	end

	slot1 = slot0._simagelogo.gameObject:GetComponent(typeof(UnityEngine.UI.Image))

	slot1:SetNativeSize()

	slot0._co = coroutine.start(slot0._addLogo, slot0, slot0._texture, slot1.sprite.texture, slot0:_getRect(slot0._texture, slot0._simagelogo.gameObject))
end

function slot0._onCoroutineDone(slot0)
	slot0._msg = slot0:_saveImage(slot0._texture)
	slot0._image.texture = slot0._texture
	slot0._canClick = true
end

function slot0._getRect(slot0, slot1, slot2)
	slot2:GetComponent(typeof(UnityEngine.RectTransform)):GetWorldCorners(System.Array.CreateInstance(typeof(Vector3), 4))

	slot10 = Vector2
	slot6 = System.Array.CreateInstance(typeof(slot10), 4)

	for slot10 = 0, 3 do
		slot6[slot10] = UnityEngine.RectTransformUtility.WorldToScreenPoint(gohelper.find("UICamera"):GetComponent(typeof(UnityEngine.Camera)), slot5[slot10])
	end

	slot7 = slot6[2] - slot6[0]

	return UnityEngine.Rect.New(Vector2(slot1.width - slot7.x, slot1.height - slot7.y), slot7)
end

function slot0._addLogo(slot0, slot1, slot2, slot3)
	WaitForEndOfFrame()

	slot4 = UnityEngine.RenderTexture.GetTemporary(slot1.width, slot1.height, 0, UnityEngine.RenderTextureFormat.Default)
	UnityEngine.RenderTexture.active = slot4

	UnityEngine.GL.PushMatrix()
	UnityEngine.GL.LoadPixelMatrix(0, slot1.width, slot1.height, 0)
	UnityEngine.Graphics.Blit(slot1, slot4)
	UnityEngine.Graphics.DrawTexture(slot3, slot2)
	slot1:ReadPixels(UnityEngine.Rect.New(0, 0, slot1.width, slot1.height), 0, 0)
	slot1:Apply()
	UnityEngine.GL.PopMatrix()

	UnityEngine.RenderTexture.active = UnityEngine.RenderTexture.active

	UnityEngine.RenderTexture.ReleaseTemporary(slot4)
	slot0:_onCoroutineDone()
end

function slot0._saveImage(slot0, slot1)
	slot4 = System.DateTime.Now
	slot6 = System.IO.Path.Combine(System.IO.Path.Combine(UnityEngine.Application.persistentDataPath, "screenshot"), string.format("screenshot_%s%s%s_%s%s%s%s.png", slot4.Year, slot4.Month, slot4.Day, slot4.Hour, slot4.Minute, slot4.Second, slot4.Millisecond))

	SLFramework.FileHelper.WriteAllBytesToPath(slot6, UnityEngine.ImageConversion.EncodeToPNG(slot1))

	return slot6
end

function slot0.onClose(slot0)
	slot0._viewOpen = false

	UnityEngine.Object.Destroy(slot0._texture)
end

function slot0.onDestroyView(slot0)
	if slot0._co then
		coroutine.stop(slot0._co)
	end

	slot4 = slot0

	TaskDispatcher.cancelTask(slot0._overTime, slot4)

	for slot4, slot5 in ipairs(slot0._listenerList) do
		slot5:RemoveClickListener()
	end

	slot0._simagelogo:UnLoadImage()
end

return slot0
