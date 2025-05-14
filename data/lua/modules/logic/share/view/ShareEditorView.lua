module("modules.logic.share.view.ShareEditorView", package.seeall)

local var_0_0 = class("ShareEditorView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gorawImage = gohelper.findChild(arg_1_0.viewGO, "container/frame/#go_rawImage")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "container/frame/#go_content")
	arg_1_0._goplatformitem = gohelper.findChild(arg_1_0.viewGO, "container/frame/#go_platformitem")
	arg_1_0._togglehideview = gohelper.findChildToggle(arg_1_0.viewGO, "container/frame/#toggle_hideview")
	arg_1_0._simagelogo = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_logo")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._viewOpen = false

	gohelper.setActive(arg_4_0._togglehideview.gameObject, false)

	local var_4_0

	if SDKMgr.instance:getChannelId() == SDKMgr.ChannelId.QQMobile then
		var_4_0 = {
			"fenxiang_qq",
			"fenxiang_kongjian"
		}
	elseif SDKMgr.instance:getChannelId() == SDKMgr.ChannelId.Douyin then
		var_4_0 = {
			"fenxiang_douyin"
		}
	else
		var_4_0 = {
			"fenxiang_weixin",
			"fenxiang_pengyouqvan",
			"fenxiang_weibo",
			"fenxiang_qq",
			"fenxiang_kongjian",
			"fenxiang_douyin",
			"fenxiang_xiaohongshu",
			"fenxiang_xiazai"
		}
	end

	if GameChannelConfig.isEfun() then
		var_4_0 = {
			"fenxiang_facebook",
			"fenxiang_instagram",
			"fenxiang_line",
			"fenxiang_discord",
			"fenxiang_xiazai"
		}
	else
		var_4_0 = {
			"fenxiang_facebook",
			"fenxiang_twitter",
			"fenxiang_xiazai"
		}
	end

	arg_4_0._listenerList = arg_4_0:getUserDataTb_()

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_1 = gohelper.clone(arg_4_0._goplatformitem, arg_4_0._gocontent, iter_4_1)

		gohelper.setActive(var_4_1, true)

		local var_4_2 = var_4_1:GetComponent(gohelper.Type_Image)

		UISpriteSetMgr.instance:setShareSprite(var_4_2, iter_4_1)

		local var_4_3 = SLFramework.UGUI.UIClickListener.Get(var_4_1)

		var_4_3:AddClickListener(arg_4_0._onClick, arg_4_0, iter_4_1)
		table.insert(arg_4_0._listenerList, var_4_3)
	end
end

function var_0_0._onClick(arg_5_0, arg_5_1)
	if not arg_5_0._canClick then
		return
	end

	if string.nilorempty(arg_5_0._msg) then
		logError("图片地址为空")

		return
	end

	logNormal(arg_5_0._msg)

	if arg_5_1 == "fenxiang_weixin" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.WechatFriend, SDKMgr.ShareContentType.Image, arg_5_0._msg)
	elseif arg_5_1 == "fenxiang_pengyouqvan" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.WechatMoment, SDKMgr.ShareContentType.Image, arg_5_0._msg)
	elseif arg_5_1 == "fenxiang_weibo" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.SinaWeibo, SDKMgr.ShareContentType.Image, arg_5_0._msg)
	elseif arg_5_1 == "fenxiang_douyin" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.TikTok, SDKMgr.ShareContentType.Image, arg_5_0._msg)
	elseif arg_5_1 == "fenxiang_xiaohongshu" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.XiaoHongShu, SDKMgr.ShareContentType.Image, arg_5_0._msg)
	elseif arg_5_1 == "fenxiang_qq" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.QQ, SDKMgr.ShareContentType.Image, arg_5_0._msg)
	elseif arg_5_1 == "fenxiang_kongjian" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.QQZone, SDKMgr.ShareContentType.Image, arg_5_0._msg)
	elseif arg_5_1 == "fenxiang_xiazai" then
		SDKMgr.instance:saveImage(arg_5_0._msg)
	elseif arg_5_1 == "fenxiang_facebook" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.Facebook, SDKMgr.ShareContentType.Image, arg_5_0._msg)
	elseif arg_5_1 == "fenxiang_twitter" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.Twitter, SDKMgr.ShareContentType.Image, arg_5_0._msg)
	elseif arg_5_1 == "fenxiang_line" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.LINE, SDKMgr.ShareContentType.Image, arg_5_0._msg)
	elseif arg_5_1 == "fenxiang_whatsapp" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.WHATSAPP, SDKMgr.ShareContentType.Image, arg_5_0._msg)
	elseif arg_5_1 == "fenxiang_instagram" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.INSTAGRAM, SDKMgr.ShareContentType.Image, arg_5_0._msg)
	elseif arg_5_1 == "fenxiang_discord" then
		SDKMgr.instance:shareMedia(SDKMgr.SharePlatform.DISCORD, SDKMgr.ShareContentType.Image, arg_5_0._msg)
	end
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._viewOpen = true
	arg_6_0._canClick = false
	arg_6_0._texture = arg_6_0.viewParam
	arg_6_0._image = gohelper.onceAddComponent(arg_6_0._gorawImage, gohelper.Type_RawImage)
	arg_6_0._image.texture = arg_6_0._texture

	arg_6_0._simagelogo:LoadImage(ResUrl.getLoginBgLangIcon("bg_logo"), arg_6_0._logoLoaded, arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._overTime, arg_6_0, 1)
end

function var_0_0._overTime(arg_7_0)
	arg_7_0._canClick = true
end

function var_0_0._logoLoaded(arg_8_0)
	if not arg_8_0._viewOpen then
		return
	end

	local var_8_0 = arg_8_0._simagelogo.gameObject:GetComponent(typeof(UnityEngine.UI.Image))

	var_8_0:SetNativeSize()

	local var_8_1 = var_8_0.sprite.texture
	local var_8_2 = arg_8_0:_getRect(arg_8_0._texture, arg_8_0._simagelogo.gameObject)

	arg_8_0._co = coroutine.start(arg_8_0._addLogo, arg_8_0, arg_8_0._texture, var_8_1, var_8_2)
end

function var_0_0._onCoroutineDone(arg_9_0)
	arg_9_0._msg = arg_9_0:_saveImage(arg_9_0._texture)
	arg_9_0._image.texture = arg_9_0._texture
	arg_9_0._canClick = true
end

function var_0_0._getRect(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = gohelper.find("UICamera"):GetComponent(typeof(UnityEngine.Camera))
	local var_10_1 = arg_10_2:GetComponent(typeof(UnityEngine.RectTransform))
	local var_10_2 = System.Array.CreateInstance(typeof(Vector3), 4)

	var_10_1:GetWorldCorners(var_10_2)

	local var_10_3 = System.Array.CreateInstance(typeof(Vector2), 4)

	for iter_10_0 = 0, 3 do
		var_10_3[iter_10_0] = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_10_0, var_10_2[iter_10_0])
	end

	local var_10_4 = var_10_3[2] - var_10_3[0]
	local var_10_5 = Vector2(arg_10_1.width - var_10_4.x, arg_10_1.height - var_10_4.y)

	return UnityEngine.Rect.New(var_10_5, var_10_4)
end

function var_0_0._addLogo(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	WaitForEndOfFrame()

	local var_11_0 = UnityEngine.RenderTexture.GetTemporary(arg_11_1.width, arg_11_1.height, 0, UnityEngine.RenderTextureFormat.Default)
	local var_11_1 = UnityEngine.RenderTexture.active

	UnityEngine.RenderTexture.active = var_11_0

	UnityEngine.GL.PushMatrix()
	UnityEngine.GL.LoadPixelMatrix(0, arg_11_1.width, arg_11_1.height, 0)
	UnityEngine.Graphics.Blit(arg_11_1, var_11_0)
	UnityEngine.Graphics.DrawTexture(arg_11_3, arg_11_2)
	arg_11_1:ReadPixels(UnityEngine.Rect.New(0, 0, arg_11_1.width, arg_11_1.height), 0, 0)
	arg_11_1:Apply()
	UnityEngine.GL.PopMatrix()

	UnityEngine.RenderTexture.active = var_11_1

	UnityEngine.RenderTexture.ReleaseTemporary(var_11_0)
	arg_11_0:_onCoroutineDone()
end

function var_0_0._saveImage(arg_12_0, arg_12_1)
	local var_12_0 = UnityEngine.ImageConversion.EncodeToPNG(arg_12_1)
	local var_12_1 = System.IO.Path.Combine(UnityEngine.Application.persistentDataPath, "screenshot")
	local var_12_2 = System.DateTime.Now
	local var_12_3 = string.format("screenshot_%s%s%s_%s%s%s%s.png", var_12_2.Year, var_12_2.Month, var_12_2.Day, var_12_2.Hour, var_12_2.Minute, var_12_2.Second, var_12_2.Millisecond)
	local var_12_4 = System.IO.Path.Combine(var_12_1, var_12_3)

	SLFramework.FileHelper.WriteAllBytesToPath(var_12_4, var_12_0)

	return var_12_4
end

function var_0_0.onClose(arg_13_0)
	arg_13_0._viewOpen = false

	UnityEngine.Object.Destroy(arg_13_0._texture)
end

function var_0_0.onDestroyView(arg_14_0)
	if arg_14_0._co then
		coroutine.stop(arg_14_0._co)
	end

	TaskDispatcher.cancelTask(arg_14_0._overTime, arg_14_0)

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._listenerList) do
		iter_14_1:RemoveClickListener()
	end

	arg_14_0._simagelogo:UnLoadImage()
end

return var_0_0
