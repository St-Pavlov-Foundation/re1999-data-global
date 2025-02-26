module("modules.logic.season.view1_6.Season1_6RetailLevelInfoView", package.seeall)

slot0 = class("Season1_6RetailLevelInfoView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageuppermask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_uppermask")
	slot0._simagedecorate = gohelper.findChildSingleImage(slot0.viewGO, "#simage_decorate")
	slot0._btnclose1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close1")
	slot0._btnclose2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close2")
	slot0._gobottom = gohelper.findChild(slot0.viewGO, "bottom")
	slot0._gonormalcondition = gohelper.findChild(slot0.viewGO, "bottom/#go_conditions/#go_normalcondition")
	slot0._txtnormalrule = gohelper.findChildText(slot0.viewGO, "bottom/#go_conditions/#go_normalcondition/#txt_normalrule")
	slot0._gospecialcondition = gohelper.findChild(slot0.viewGO, "bottom/#go_conditions/#go_specialcondition")
	slot0._txtspecialrule = gohelper.findChildText(slot0.viewGO, "bottom/#go_conditions/#go_specialcondition/#txt_specialrule")
	slot0._txtlevelname = gohelper.findChildText(slot0.viewGO, "bottom/#txt_levelname")
	slot0._txtenemylevelnum = gohelper.findChildText(slot0.viewGO, "bottom/txt_enemylevel/#txt_enemylevelnum")
	slot0._scrollcelebritycard = gohelper.findChildScrollRect(slot0.viewGO, "bottom/rewards/rewardlist/#scroll_celebritycard")
	slot0._gocarditem = gohelper.findChild(slot0.viewGO, "bottom/rewards/rewardlist/#scroll_celebritycard/scrollcontent_seasoncelebritycarditem")
	slot0._txtdecr = gohelper.findChildText(slot0.viewGO, "bottom/#txt_decr")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_close")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_start")
	slot0._gotag = gohelper.findChild(slot0.viewGO, "bottom/#go_tag")
	slot0._txttagdesc = gohelper.findChildText(slot0.viewGO, "bottom/#go_tag/descbg/#txt_tagdesc")
	slot0._gostageitem = gohelper.findChild(slot0.viewGO, "bottom/stages/#go_stageitem")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_leftbg")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_rightbg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose1:AddClickListener(slot0._btnclose1OnClick, slot0)
	slot0._btnclose2:AddClickListener(slot0._btnclose2OnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose1:RemoveClickListener()
	slot0._btnclose2:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnstart:RemoveClickListener()
end

function slot0._btnclose1OnClick(slot0)
	slot0:closeThis()
end

function slot0._btnclose2OnClick(slot0)
	slot0:closeThis()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnstartOnClick(slot0)
	Activity104Model.instance:enterAct104Battle(slot0.viewParam.episodeId, 0)
end

function slot0._editableInitView(slot0)
	slot0._simageuppermask:LoadImage(ResUrl.getSeasonIcon("full/seasonsecretlandentrance_mask.png"))
	slot0._simagedecorate:LoadImage(ResUrl.getSeasonIcon("particle.png"))
	slot0._simageleftbg:LoadImage(SeasonViewHelper.getSeasonIcon("msg_xia.png"))
	slot0._simagerightbg:LoadImage(SeasonViewHelper.getSeasonIcon("msg_shang.png"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._cardItems = {}

	slot0:_setInfo()
end

slot1 = {
	targetFlagUIPosX = -32.7,
	targetFlagUIScale = 2.3,
	targetFlagUIPosY = 28.3
}

function slot0._setInfo(slot0)
	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectRetail, slot0.viewParam.retail.position)

	slot2 = Activity104Model.instance:getCurSeasonId()
	slot0._txtlevelname.text = SeasonConfig.instance:getSeasonTagDesc(slot2, slot0.viewParam.retail.tag).name .. " " .. GameUtil.getRomanNums(math.min(Activity104Model.instance:getAct104CurStage(), 6))
	slot9 = slot2
	slot0._txtenemylevelnum.text = HeroConfig.instance:getCommonLevelDisplay(SeasonConfig.instance:getSeasonRetailCo(slot9, Activity104Model.instance:getRetailStage()).level)
	slot4 = Activity104Model.instance:getRetailEpisodeTag(slot0.viewParam.retail.id)
	slot8 = slot4

	gohelper.setActive(slot0._gotag, not string.nilorempty(slot8))

	slot0._txttagdesc.text = tostring(slot4)

	for slot8, slot9 in pairs(slot0._cardItems) do
		gohelper.setActive(slot9.go, false)
	end

	for slot8 = 1, #slot0.viewParam.retail.showActivity104EquipIds do
		if not slot0._cardItems[slot8] then
			slot0._cardItems[slot8] = Season1_6CelebrityCardItem.New()

			slot0._cardItems[slot8]:init(slot0._gocarditem, slot0.viewParam.retail.showActivity104EquipIds[slot8], uv0)
		else
			gohelper.setActive(slot0._cardItems[slot8].go, true)
			slot0._cardItems[slot8]:reset(slot9)
		end

		slot0._cardItems[slot8]:showTag(true)
		slot0._cardItems[slot8]:showProbability(true)
	end

	gohelper.setActive(slot0._gonormalcondition, slot0.viewParam.retail.advancedId ~= 0 and slot0.viewParam.retail.advancedRare == 1)
	gohelper.setActive(slot0._gospecialcondition, slot0.viewParam.retail.advancedId ~= 0 and slot0.viewParam.retail.advancedRare == 2)

	if slot0.viewParam.retail.advancedId ~= 0 then
		if slot0.viewParam.retail.advancedRare == 1 then
			slot0._txtnormalrule.text = "      " .. lua_condition.configDict[slot0.viewParam.retail.advancedId].desc
		elseif slot0.viewParam.retail.advancedRare == 2 then
			slot0._txtspecialrule.text = slot5
		end
	end

	slot0:_refreshStateUI()
end

slot0.MaxStageCount = 7

function slot0._refreshStateUI(slot0)
	slot0._stageItemsTab = slot0._stageItemsTab or slot0:getUserDataTb_()
	slot1 = Activity104Model.instance:getAct104CurStage()

	for slot5 = 1, uv0.MaxStageCount do
		if not slot0._stageItemsTab[slot5] then
			table.insert(slot0._stageItemsTab, slot5, gohelper.cloneInPlace(slot0._gostageitem, "stageitem_" .. slot5))
		end

		gohelper.setActive(slot6, slot5 <= 6 or slot5 <= slot1)
		gohelper.setActive(gohelper.findChildImage(slot6, "light").gameObject, slot5 <= slot1)
		gohelper.setActive(gohelper.findChildImage(slot6, "dark").gameObject, slot1 < slot5)
		SLFramework.UGUI.GuiHelper.SetColor(slot8, slot5 == 7 and "#B83838" or "#FFFFFF")
	end
end

function slot0.onClose(slot0)
	Activity104Controller.instance:dispatchEvent(Activity104Event.SelectRetail)
end

function slot0.onDestroyView(slot0)
	if slot0._cardItems then
		for slot4, slot5 in pairs(slot0._cardItems) do
			slot5:destroy()
		end

		slot0._cardItems = nil
	end

	slot0._simageuppermask:UnLoadImage()
	slot0._simagedecorate:UnLoadImage()
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
end

return slot0
