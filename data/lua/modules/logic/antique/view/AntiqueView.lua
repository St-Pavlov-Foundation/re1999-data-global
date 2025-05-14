module("modules.logic.antique.view.AntiqueView", package.seeall)

local var_0_0 = class("AntiqueView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagegifticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Item/#simage_gifticon")
	arg_1_0._simagesign = gohelper.findChildSingleImage(arg_1_0.viewGO, "Item/#simage_sign")
	arg_1_0._imgsignIcon = gohelper.findChildImage(arg_1_0.viewGO, "Item/#txt_name/#image_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "Item/#txt_name")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "Item/#txt_name/#txt_nameen")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#txt_title")
	arg_1_0._txttitleen = gohelper.findChildText(arg_1_0.viewGO, "#txt_title/#txt_titleen")
	arg_1_0._btnPlay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#txt_title/#btn_Play")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc/#txt_time")
	arg_1_0._goeffect = gohelper.findChild(arg_1_0.viewGO, "#go_effect")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnPlay:AddClickListener(arg_2_0._onClickPlayBtn, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnPlay:RemoveClickListener()
end

function var_0_0._onClickPlayBtn(arg_4_0)
	local var_4_0 = AntiqueConfig.instance:getAntiqueCo(arg_4_0._antiqueId)

	StoryController.instance:playStory(var_4_0.storyId)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getAntiqueIcon("antique_fullbg"))
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._antiqueId = arg_6_0.viewParam

	arg_6_0:_refreshUI()
end

local var_0_1 = {
	{
		x = -80,
		y = -10,
		anchorMin = Vector2(0, 0.5),
		anchorMax = Vector2(0, 0.5)
	},
	{
		x = 80,
		y = -10,
		anchorMin = Vector2(1, 0.5),
		anchorMax = Vector2(1, 0.5)
	},
	{
		x = 0,
		y = 50,
		anchorMin = Vector2(0.5, 1),
		anchorMax = Vector2(0.5, 1)
	},
	{
		x = 0,
		y = -80,
		anchorMin = Vector2(0.5, 0),
		anchorMax = Vector2(0.5, 0)
	}
}

function var_0_0._refreshUI(arg_7_0)
	local var_7_0 = AntiqueConfig.instance:getAntiqueCo(arg_7_0._antiqueId)

	arg_7_0._txtname.text = var_7_0.name
	arg_7_0._txtnameen.text = var_7_0.nameen
	arg_7_0._txttitle.text = var_7_0.title
	arg_7_0._txttitleen.text = var_7_0.titleen
	arg_7_0._txtdesc.text = var_7_0.desc

	local var_7_1 = AntiqueModel.instance:getAntique(arg_7_0._antiqueId)

	if not var_7_1 then
		gohelper.setActive(arg_7_0._btnPlay.gameObject, false)

		arg_7_0._txttime.text = ""
	else
		gohelper.setActive(arg_7_0._btnPlay.gameObject, var_7_0.storyId and var_7_0.storyId > 0)

		local var_7_2 = TimeUtil.localTime2ServerTimeString(math.floor(var_7_1.getTime / 1000))

		arg_7_0._txttime.text = "——" .. string.format(luaLang("receive_time"), var_7_2)
	end

	arg_7_0._simagegifticon:LoadImage(ResUrl.getAntiqueIcon(var_7_0.gifticon))

	local var_7_3 = var_7_0.iconArea

	if var_7_3 > 0 then
		local var_7_4 = var_0_1[var_7_3]

		arg_7_0._imgsignIcon.transform.anchorMax = var_7_4.anchorMax
		arg_7_0._imgsignIcon.transform.anchorMin = var_7_4.anchorMin

		recthelper.setAnchor(arg_7_0._imgsignIcon.transform, var_7_4.x, var_7_4.y)
		gohelper.setActive(arg_7_0._imgsignIcon.gameObject, true)
		gohelper.setActive(arg_7_0._simagesign.gameObject, false)
		UISpriteSetMgr.instance:setAntiqueSprite(arg_7_0._imgsignIcon, var_7_0.sign, true)
	else
		gohelper.setActive(arg_7_0._imgsignIcon.gameObject, false)
		gohelper.setActive(arg_7_0._simagesign.gameObject, true)
		arg_7_0._simagesign:LoadImage(ResUrl.getSignature(var_7_0.sign))
	end

	local var_7_5 = var_7_0.effect
	local var_7_6 = not string.nilorempty(var_7_5)

	gohelper.setActive(arg_7_0._goeffect, var_7_6)

	if var_7_6 then
		local var_7_7 = ResUrl.getAntiqueEffect(var_7_5)

		if not arg_7_0._loader then
			arg_7_0._loader = PrefabInstantiate.Create(arg_7_0._goeffect)
		end

		if arg_7_0._effectPrefab then
			gohelper.destroy(arg_7_0._effectPrefab)
			arg_7_0._loader:dispose()

			arg_7_0._effectPrefab = nil
		end

		arg_7_0._loader:startLoad(var_7_7, arg_7_0.onLoadCallBack, arg_7_0)
	end
end

function var_0_0.onLoadCallBack(arg_8_0)
	arg_8_0._effectPrefab = arg_8_0._loader:getInstGO()
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simagebg:UnLoadImage()
	arg_10_0._simagegifticon:UnLoadImage()
	arg_10_0._simagesign:UnLoadImage()

	if arg_10_0._loader then
		arg_10_0._loader:dispose()

		arg_10_0._loader = nil
	end
end

return var_0_0
