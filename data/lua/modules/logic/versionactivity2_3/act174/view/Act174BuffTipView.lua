module("modules.logic.versionactivity2_3.act174.view.Act174BuffTipView", package.seeall)

slot0 = class("Act174BuffTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclosetip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closetip")
	slot0._goscrolltips = gohelper.findChild(slot0.viewGO, "#go_scrolltips")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "#go_scrolltips/viewport/content/go_title/#txt_title")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_scrolltips/viewport/content/go_title/#image_icon")
	slot0._goskillitem = gohelper.findChild(slot0.viewGO, "#go_scrolltips/viewport/content/#go_skillitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclosetip:AddClickListener(slot0._btnclosetipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclosetip:RemoveClickListener()
end

function slot0._btnclosetipOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#go_scrolltips/viewport/content")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)

	if not slot0.viewParam then
		logError("please open with param")

		return
	end

	slot1 = Activity174Model.instance:getActInfo():getGameInfo()

	if slot0.viewParam.isEnemy then
		slot3 = slot1:getFightInfo().matchInfo

		UISpriteSetMgr.instance:setAct174Sprite(slot0._imageicon, "act174_ready_icon_enemy")

		slot0._txttitle.text = luaLang("act174_enhance_enemy")

		if slot1:getFightInfo() then
			slot0.enhanceList = slot3.enhanceId
			slot0.endEnhanceList = slot3.endEnhanceId
		else
			logError("dont exist fightInfo")

			return
		end
	else
		slot3 = slot1:getWarehouseInfo()

		UISpriteSetMgr.instance:setAct174Sprite(slot0._imageicon, "act174_ready_icon_player")

		slot0._txttitle.text = luaLang("act174_enhance_player")
		slot0.enhanceList = slot3.enhanceId
		slot0.endEnhanceList = slot3.endEnhanceId
	end

	slot0.buffIconList = slot0:getUserDataTb_()

	for slot6, slot7 in ipairs(slot0.enhanceList) do
		slot8 = gohelper.cloneInPlace(slot0._goskillitem)
		slot9 = lua_activity174_enhance.configDict[slot7]
		slot11 = gohelper.findChildSingleImage(slot8, "skillicon")
		slot12 = gohelper.findChildText(slot8, "layout/txt_dec")
		gohelper.findChildText(slot8, "txt_skill").text = slot9.title

		if slot0.endEnhanceList and tabletool.indexOf(slot0.endEnhanceList, slot7) then
			slot13 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act174_enhance_overduea"), slot9.desc)
		end

		slot12.text = slot13

		slot11:LoadImage(ResUrl.getAct174BuffIcon(slot9.icon))

		slot0.buffIconList[#slot0.buffIconList + 1] = slot11
	end

	gohelper.setActive(slot0._goskillitem, false)
	TaskDispatcher.runDelay(slot0.refreshAnchor, slot0, 0.01)
end

function slot0.refreshAnchor(slot0)
	slot5 = slot0.viewParam.pos

	if slot0.viewParam.isDown then
		recthelper.setAnchor(slot1, slot5.x, slot5.y + (recthelper.getHeight(slot0._goscrolltips.transform) < recthelper.getHeight(slot0._goContent.transform) and slot2 or slot3))
	else
		recthelper.setAnchor(slot1, slot5.x, slot5.y)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.buffIconList) do
		slot5:UnLoadImage()
	end

	TaskDispatcher.cancelTask(slot0.refreshAnchor, slot0)
end

return slot0
