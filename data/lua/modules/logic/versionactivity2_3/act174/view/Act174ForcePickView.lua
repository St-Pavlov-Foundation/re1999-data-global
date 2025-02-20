module("modules.logic.versionactivity2_3.act174.view.Act174ForcePickView", package.seeall)

slot0 = class("Act174ForcePickView", BaseView)

function slot0.onInitView(slot0)
	slot0._goBuff = gohelper.findChild(slot0.viewGO, "#go_Buff")
	slot0._goBuild = gohelper.findChild(slot0.viewGO, "#go_Build")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._onEscBtnClick(slot0)
	if slot0.gameInfo.gameCount == 0 then
		slot0:closeThis()
	end
end

function slot0._editableInitView(slot0)
	slot0._goTitle = gohelper.findChild(slot0.viewGO, "#go_Buff/simage_title/txt_title")
	slot0._goTitleEndless = gohelper.findChild(slot0.viewGO, "#go_Buff/simage_title/txt_title_endless")
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Activity174Controller.instance, Activity174Event.SeasonChange, slot0.closeThis, slot0)
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscBtnClick, slot0)

	slot0.actId = Activity174Model.instance:getCurActId()
	slot0.bagConfig = lua_activity174_bag
	slot0.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()

	gohelper.setActive(slot0._gotopleft, slot0.gameInfo.gameCount == 0)

	slot1, slot2 = Activity174Config.instance:getMaxRound(slot0.actId, slot0.gameInfo.gameCount)

	gohelper.setActive(slot0._goTitle, not slot2)
	gohelper.setActive(slot0._goTitleEndless, slot2)
	slot0:freshPickBagItem()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.nextStep, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:clearIconList()
end

function slot0.clearIconList(slot0)
	if slot0.buffIconList then
		for slot4, slot5 in ipairs(slot0.buffIconList) do
			slot5:UnLoadImage()
		end
	end

	if slot0.heroIconList then
		for slot4, slot5 in ipairs(slot0.heroIconList) do
			slot5:UnLoadImage()
		end
	end

	if slot0.collectionIconList then
		for slot4, slot5 in ipairs(slot0.collectionIconList) do
			slot5:UnLoadImage()
		end
	end
end

function slot0.freshPickBagItem(slot0)
	if slot0.viewParam then
		slot0.forceBagInfo = slot0.viewParam

		slot0:clearIconList()

		slot0.bagType = slot0.bagConfig.configDict[slot0.forceBagInfo[1].bagInfo.bagId].type

		if slot0.bagType == Activity174Enum.BagType.Enhance then
			slot0:initBuffSelectItem()
		else
			slot0:initBuildSelectItem()
		end

		gohelper.setActive(slot0._goBuff, slot0.bagType == Activity174Enum.BagType.Enhance)
		gohelper.setActive(slot0._goBuild, slot0.bagType ~= Activity174Enum.BagType.Enhance)
		Activity174Controller.instance:dispatchEvent(slot0.bagType == Activity174Enum.BagType.Enhance and Activity174Event.ChooseBuffPackage or slot0.bagType == Activity174Enum.BagType.StartRare and Activity174Event.ChooseRolePackage or nil)
	else
		logError("please open with forceBagInfo")
	end
end

function slot0.initBuffSelectItem(slot0)
	slot0.bagAnimList = slot0:getUserDataTb_()
	slot0.buffIconList = slot0:getUserDataTb_()

	gohelper.CreateObjList(slot0, slot0._onInitBuffItem, slot0.forceBagInfo, gohelper.findChild(slot0.viewGO, "#go_Buff/scroll_view/Viewport/Content"), gohelper.findChild(slot0.viewGO, "#go_Buff/scroll_view/Viewport/Content/SelectItem"))
end

function slot0._onInitBuffItem(slot0, slot1, slot2, slot3)
	slot4 = gohelper.findChildSingleImage(slot1, "simage_bufficon")
	slot6 = gohelper.findChildText(slot1, "scroll_desc/Viewport/go_desccontent/txt_desc")
	slot8 = lua_activity174_enhance.configDict[slot2.bagInfo.enhanceId[1]]

	slot4:LoadImage(ResUrl.getAct174BuffIcon(slot8.icon))

	gohelper.findChildText(slot1, "txt_name").text = slot8.title
	slot6.text = SkillHelper.buildDesc(slot8.desc)

	SkillHelper.addHyperLinkClick(slot6)
	slot0:addClickCb(gohelper.findChildButtonWithAudio(slot1, "btn_select"), slot0.clickBag, slot0, slot3)

	slot0.buffIconList[slot3] = slot4
	slot0.bagAnimList[slot3] = slot1:GetComponent(gohelper.Type_Animator)
end

function slot0.initBuildSelectItem(slot0)
	slot0.heroIconList = slot0:getUserDataTb_()
	slot0.collectionIconList = slot0:getUserDataTb_()
	slot0.bagAnimList = slot0:getUserDataTb_()

	gohelper.CreateObjList(slot0, slot0._onInitBuildItem, slot0.forceBagInfo, gohelper.findChild(slot0.viewGO, "#go_Build/scroll_view/Viewport/Content"), gohelper.findChild(slot0.viewGO, "#go_Build/scroll_view/Viewport/Content/SelectItem"))
end

function slot0._onInitBuildItem(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "name/txt_name").text = string.split(Activity174Config.instance:getTurnCo(slot0.actId, Activity174Model.instance:getActInfo():getGameInfo().gameCount).name, "#")[slot3] or ""

	slot0:addClickCb(gohelper.findChildButtonWithAudio(slot1, "btn_select"), slot0.clickBag, slot0, slot3)

	slot10 = gohelper.findChild(slot1, "collection/collectionitem")

	for slot15, slot16 in ipairs(slot2.bagInfo.heroId) do
		slot17 = gohelper.cloneInPlace(gohelper.findChild(slot1, "role/roleitem"))
		slot18 = Activity174Config.instance:getRoleCo(slot16)
		slot20 = gohelper.findChildSingleImage(slot17, "heroicon")

		UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot17, "rare"), "bgequip" .. tostring(CharacterEnum.Color[slot18.rare]))
		UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot17, "career"), "lssx_" .. slot18.career)
		slot20:LoadImage(ResUrl.getHeadIconSmall(slot18.skinId))

		gohelper.findChildText(slot17, "name").text = slot18.name

		slot0:addClickCb(gohelper.findChildButtonWithAudio(slot17, "heroicon"), slot0.clickRole, slot0, {
			x = slot3,
			y = slot15
		})

		slot0.heroIconList[#slot0.heroIconList + 1] = slot20
	end

	for slot15, slot16 in ipairs(slot11.itemId) do
		slot17 = gohelper.cloneInPlace(slot10)
		slot18 = Activity174Config.instance:getCollectionCo(slot16)
		slot20 = gohelper.findChildSingleImage(slot17, "collectionicon")

		slot20:LoadImage(ResUrl.getRougeSingleBgCollection(slot18.icon))
		UISpriteSetMgr.instance:setAct174Sprite(gohelper.findChildImage(slot17, "rare"), "act174_propitembg_" .. slot18.rare)
		slot0:addClickCb(gohelper.findChildButtonWithAudio(slot17, "collectionicon"), slot0.clickCollection, slot0, {
			x = slot3,
			y = slot15
		})

		slot0.collectionIconList[#slot0.collectionIconList + 1] = slot20
	end

	gohelper.setActive(slot9, false)
	gohelper.setActive(slot10, false)

	slot0.bagAnimList[slot3] = slot1:GetComponent(gohelper.Type_Animator)
end

function slot0.clickBag(slot0, slot1)
	Activity174Rpc.instance:sendSelectAct174ForceBagRequest(slot0.actId, slot0.forceBagInfo[slot1].index, slot0.forcePickReply, slot0)

	slot0.selectIndex = slot1
end

function slot0.forcePickReply(slot0, slot1, slot2)
	if slot2 == 0 then
		if slot0.selectIndex and slot0.bagAnimList[slot3] then
			slot0.bagAnimList[slot3]:Play(UIAnimationName.Close)
			AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shuori_qiyuan_reset)
		end

		TaskDispatcher.runDelay(slot0.nextStep, slot0, 0.67)

		slot0.selectIndex = nil
	end
end

function slot0.clickRole(slot0, slot1)
	if slot0.forceBagInfo[slot1.x] and slot0.forceBagInfo[slot1.x].bagInfo and Activity174Config.instance:getRoleCo(slot2.heroId[slot1.y]) then
		Activity174Controller.instance:openItemTipView({
			type = Activity174Enum.ItemTipType.Character,
			co = slot4,
			showMask = true
		})
	end
end

function slot0.clickCollection(slot0, slot1)
	if slot0.forceBagInfo[slot1.x] and slot0.forceBagInfo[slot1.x].bagInfo and Activity174Config.instance:getCollectionCo(slot2.itemId[slot1.y]) then
		Activity174Controller.instance:openItemTipView({
			type = Activity174Enum.ItemTipType.Collection,
			co = slot4,
			showMask = true
		})
	end
end

function slot0.nextStep(slot0)
	if Activity174Model.instance:getActInfo():getGameInfo().state == Activity174Enum.GameState.ForceSelect then
		Activity174Controller.instance:openForcePickView(slot1:getForceBagsInfo())
	else
		Activity174Controller.instance:openGameView()
		slot0:closeThis()
	end
end

return slot0
