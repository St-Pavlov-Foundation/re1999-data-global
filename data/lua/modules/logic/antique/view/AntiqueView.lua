module("modules.logic.antique.view.AntiqueView", package.seeall)

slot0 = class("AntiqueView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagegifticon = gohelper.findChildSingleImage(slot0.viewGO, "Item/#simage_gifticon")
	slot0._simagesign = gohelper.findChildSingleImage(slot0.viewGO, "Item/#simage_sign")
	slot0._imgsignIcon = gohelper.findChildImage(slot0.viewGO, "Item/#txt_name/#image_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "Item/#txt_name")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "Item/#txt_name/#txt_nameen")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#txt_title")
	slot0._txttitleen = gohelper.findChildText(slot0.viewGO, "#txt_title/#txt_titleen")
	slot0._btnPlay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#txt_title/#btn_Play")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "#txt_desc/#txt_time")
	slot0._goeffect = gohelper.findChild(slot0.viewGO, "#go_effect")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnPlay:AddClickListener(slot0._onClickPlayBtn, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnPlay:RemoveClickListener()
end

function slot0._onClickPlayBtn(slot0)
	StoryController.instance:playStory(AntiqueConfig.instance:getAntiqueCo(slot0._antiqueId).storyId)
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getAntiqueIcon("antique_fullbg"))
end

function slot0.onOpen(slot0)
	slot0._antiqueId = slot0.viewParam

	slot0:_refreshUI()
end

slot1 = {
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

function slot0._refreshUI(slot0)
	slot1 = AntiqueConfig.instance:getAntiqueCo(slot0._antiqueId)
	slot0._txtname.text = slot1.name
	slot0._txtnameen.text = slot1.nameen
	slot0._txttitle.text = slot1.title
	slot0._txttitleen.text = slot1.titleen
	slot0._txtdesc.text = slot1.desc

	if not AntiqueModel.instance:getAntique(slot0._antiqueId) then
		gohelper.setActive(slot0._btnPlay.gameObject, false)

		slot0._txttime.text = ""
	else
		gohelper.setActive(slot0._btnPlay.gameObject, slot1.storyId and slot1.storyId > 0)

		slot0._txttime.text = "——" .. string.format(luaLang("receive_time"), TimeUtil.localTime2ServerTimeString(math.floor(slot2.getTime / 1000)))
	end

	slot0._simagegifticon:LoadImage(ResUrl.getAntiqueIcon(slot1.gifticon))

	if slot1.iconArea > 0 then
		slot4 = uv0[slot3]
		slot0._imgsignIcon.transform.anchorMax = slot4.anchorMax
		slot0._imgsignIcon.transform.anchorMin = slot4.anchorMin

		recthelper.setAnchor(slot0._imgsignIcon.transform, slot4.x, slot4.y)
		gohelper.setActive(slot0._imgsignIcon.gameObject, true)
		gohelper.setActive(slot0._simagesign.gameObject, false)
		UISpriteSetMgr.instance:setAntiqueSprite(slot0._imgsignIcon, slot1.sign, true)
	else
		gohelper.setActive(slot0._imgsignIcon.gameObject, false)
		gohelper.setActive(slot0._simagesign.gameObject, true)
		slot0._simagesign:LoadImage(ResUrl.getSignature(slot1.sign))
	end

	slot5 = not string.nilorempty(slot1.effect)

	gohelper.setActive(slot0._goeffect, slot5)

	if slot5 then
		slot6 = ResUrl.getAntiqueEffect(slot4)

		if not slot0._loader then
			slot0._loader = PrefabInstantiate.Create(slot0._goeffect)
		end

		if slot0._effectPrefab then
			gohelper.destroy(slot0._effectPrefab)
			slot0._loader:dispose()

			slot0._effectPrefab = nil
		end

		slot0._loader:startLoad(slot6, slot0.onLoadCallBack, slot0)
	end
end

function slot0.onLoadCallBack(slot0)
	slot0._effectPrefab = slot0._loader:getInstGO()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagegifticon:UnLoadImage()
	slot0._simagesign:UnLoadImage()

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end
end

return slot0
