module("modules.logic.versionactivity2_3.act174.view.Act174ForcePickView", package.seeall)

local var_0_0 = class("Act174ForcePickView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goBuff = gohelper.findChild(arg_1_0.viewGO, "#go_Buff")
	arg_1_0._goBuild = gohelper.findChild(arg_1_0.viewGO, "#go_Build")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

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

function var_0_0._onEscBtnClick(arg_4_0)
	if arg_4_0.gameInfo.gameCount == 0 then
		arg_4_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goTitle = gohelper.findChild(arg_5_0.viewGO, "#go_Buff/simage_title/txt_title")
	arg_5_0._goTitleEndless = gohelper.findChild(arg_5_0.viewGO, "#go_Buff/simage_title/txt_title_endless")
end

function var_0_0.onUpdateParam(arg_6_0)
	arg_6_0:onOpen()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addEventCb(Activity174Controller.instance, Activity174Event.SeasonChange, arg_7_0.closeThis, arg_7_0)
	NavigateMgr.instance:addEscape(arg_7_0.viewName, arg_7_0._onEscBtnClick, arg_7_0)

	arg_7_0.actId = Activity174Model.instance:getCurActId()
	arg_7_0.bagConfig = lua_activity174_bag
	arg_7_0.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()

	gohelper.setActive(arg_7_0._gotopleft, arg_7_0.gameInfo.gameCount == 0)

	local var_7_0, var_7_1 = Activity174Config.instance:getMaxRound(arg_7_0.actId, arg_7_0.gameInfo.gameCount)

	gohelper.setActive(arg_7_0._goTitle, not var_7_1)
	gohelper.setActive(arg_7_0._goTitleEndless, var_7_1)
	arg_7_0:freshPickBagItem()
end

function var_0_0.onClose(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.nextStep, arg_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0:clearIconList()
end

function var_0_0.clearIconList(arg_10_0)
	if arg_10_0.buffIconList then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.buffIconList) do
			iter_10_1:UnLoadImage()
		end
	end

	if arg_10_0.heroIconList then
		for iter_10_2, iter_10_3 in ipairs(arg_10_0.heroIconList) do
			iter_10_3:UnLoadImage()
		end
	end

	if arg_10_0.collectionIconList then
		for iter_10_4, iter_10_5 in ipairs(arg_10_0.collectionIconList) do
			iter_10_5:UnLoadImage()
		end
	end
end

function var_0_0.freshPickBagItem(arg_11_0)
	if arg_11_0.viewParam then
		arg_11_0.forceBagInfo = arg_11_0.viewParam

		arg_11_0:clearIconList()

		local var_11_0 = arg_11_0.forceBagInfo[1].bagInfo.bagId

		arg_11_0.bagType = arg_11_0.bagConfig.configDict[var_11_0].type

		if arg_11_0.bagType == Activity174Enum.BagType.Enhance then
			arg_11_0:initBuffSelectItem()
		else
			arg_11_0:initBuildSelectItem()
		end

		gohelper.setActive(arg_11_0._goBuff, arg_11_0.bagType == Activity174Enum.BagType.Enhance)
		gohelper.setActive(arg_11_0._goBuild, arg_11_0.bagType ~= Activity174Enum.BagType.Enhance)
		Activity174Controller.instance:dispatchEvent(arg_11_0.bagType == Activity174Enum.BagType.Enhance and Activity174Event.ChooseBuffPackage or arg_11_0.bagType == Activity174Enum.BagType.StartRare and Activity174Event.ChooseRolePackage or nil)
	else
		logError("please open with forceBagInfo")
	end
end

function var_0_0.initBuffSelectItem(arg_12_0)
	arg_12_0.bagAnimList = arg_12_0:getUserDataTb_()
	arg_12_0.buffIconList = arg_12_0:getUserDataTb_()

	local var_12_0 = gohelper.findChild(arg_12_0.viewGO, "#go_Buff/scroll_view/Viewport/Content")
	local var_12_1 = gohelper.findChild(arg_12_0.viewGO, "#go_Buff/scroll_view/Viewport/Content/SelectItem")

	gohelper.CreateObjList(arg_12_0, arg_12_0._onInitBuffItem, arg_12_0.forceBagInfo, var_12_0, var_12_1)
end

function var_0_0._onInitBuffItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = gohelper.findChildSingleImage(arg_13_1, "simage_bufficon")
	local var_13_1 = gohelper.findChildText(arg_13_1, "txt_name")
	local var_13_2 = gohelper.findChildText(arg_13_1, "scroll_desc/Viewport/go_desccontent/txt_desc")
	local var_13_3 = arg_13_2.bagInfo
	local var_13_4 = lua_activity174_enhance.configDict[var_13_3.enhanceId[1]]

	var_13_0:LoadImage(ResUrl.getAct174BuffIcon(var_13_4.icon))

	var_13_1.text = var_13_4.title
	var_13_2.text = SkillHelper.buildDesc(var_13_4.desc)

	SkillHelper.addHyperLinkClick(var_13_2)

	local var_13_5 = gohelper.findChildButtonWithAudio(arg_13_1, "btn_select")

	arg_13_0:addClickCb(var_13_5, arg_13_0.clickBag, arg_13_0, arg_13_3)

	arg_13_0.buffIconList[arg_13_3] = var_13_0
	arg_13_0.bagAnimList[arg_13_3] = arg_13_1:GetComponent(gohelper.Type_Animator)
end

function var_0_0.initBuildSelectItem(arg_14_0)
	arg_14_0.heroIconList = arg_14_0:getUserDataTb_()
	arg_14_0.collectionIconList = arg_14_0:getUserDataTb_()
	arg_14_0.bagAnimList = arg_14_0:getUserDataTb_()

	local var_14_0 = gohelper.findChild(arg_14_0.viewGO, "#go_Build/scroll_view/Viewport/Content")
	local var_14_1 = gohelper.findChild(arg_14_0.viewGO, "#go_Build/scroll_view/Viewport/Content/SelectItem")

	gohelper.CreateObjList(arg_14_0, arg_14_0._onInitBuildItem, arg_14_0.forceBagInfo, var_14_0, var_14_1)
end

function var_0_0._onInitBuildItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = Activity174Model.instance:getActInfo():getGameInfo()
	local var_15_1 = Activity174Config.instance:getTurnCo(arg_15_0.actId, var_15_0.gameCount)
	local var_15_2 = string.split(var_15_1.name, "#")

	gohelper.findChildText(arg_15_1, "name/txt_name").text = var_15_2[arg_15_3] or ""

	local var_15_3 = gohelper.findChildButtonWithAudio(arg_15_1, "btn_select")

	arg_15_0:addClickCb(var_15_3, arg_15_0.clickBag, arg_15_0, arg_15_3)

	local var_15_4 = gohelper.findChild(arg_15_1, "role/roleitem")
	local var_15_5 = gohelper.findChild(arg_15_1, "collection/collectionitem")
	local var_15_6 = arg_15_2.bagInfo

	for iter_15_0, iter_15_1 in ipairs(var_15_6.heroId) do
		local var_15_7 = gohelper.cloneInPlace(var_15_4)
		local var_15_8 = Activity174Config.instance:getRoleCo(iter_15_1)
		local var_15_9 = gohelper.findChildImage(var_15_7, "rare")
		local var_15_10 = gohelper.findChildSingleImage(var_15_7, "heroicon")
		local var_15_11 = gohelper.findChildButtonWithAudio(var_15_7, "heroicon")
		local var_15_12 = gohelper.findChildImage(var_15_7, "career")
		local var_15_13 = gohelper.findChildText(var_15_7, "name")

		UISpriteSetMgr.instance:setCommonSprite(var_15_9, "bgequip" .. tostring(CharacterEnum.Color[var_15_8.rare]))
		UISpriteSetMgr.instance:setCommonSprite(var_15_12, "lssx_" .. var_15_8.career)
		var_15_10:LoadImage(ResUrl.getHeadIconSmall(var_15_8.skinId))

		var_15_13.text = var_15_8.name

		arg_15_0:addClickCb(var_15_11, arg_15_0.clickRole, arg_15_0, {
			x = arg_15_3,
			y = iter_15_0
		})

		arg_15_0.heroIconList[#arg_15_0.heroIconList + 1] = var_15_10
	end

	for iter_15_2, iter_15_3 in ipairs(var_15_6.itemId) do
		local var_15_14 = gohelper.cloneInPlace(var_15_5)
		local var_15_15 = Activity174Config.instance:getCollectionCo(iter_15_3)
		local var_15_16 = gohelper.findChildImage(var_15_14, "rare")
		local var_15_17 = gohelper.findChildSingleImage(var_15_14, "collectionicon")
		local var_15_18 = gohelper.findChildButtonWithAudio(var_15_14, "collectionicon")

		var_15_17:LoadImage(ResUrl.getRougeSingleBgCollection(var_15_15.icon))
		UISpriteSetMgr.instance:setAct174Sprite(var_15_16, "act174_propitembg_" .. var_15_15.rare)
		arg_15_0:addClickCb(var_15_18, arg_15_0.clickCollection, arg_15_0, {
			x = arg_15_3,
			y = iter_15_2
		})

		arg_15_0.collectionIconList[#arg_15_0.collectionIconList + 1] = var_15_17
	end

	gohelper.setActive(var_15_4, false)
	gohelper.setActive(var_15_5, false)

	arg_15_0.bagAnimList[arg_15_3] = arg_15_1:GetComponent(gohelper.Type_Animator)
end

function var_0_0.clickBag(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.forceBagInfo[arg_16_1]

	Activity174Rpc.instance:sendSelectAct174ForceBagRequest(arg_16_0.actId, var_16_0.index, arg_16_0.forcePickReply, arg_16_0)

	arg_16_0.selectIndex = arg_16_1
end

function var_0_0.forcePickReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_2 == 0 then
		local var_17_0 = arg_17_0.selectIndex

		if var_17_0 and arg_17_0.bagAnimList[var_17_0] then
			arg_17_0.bagAnimList[var_17_0]:Play(UIAnimationName.Close)
			AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shuori_qiyuan_reset)
		end

		TaskDispatcher.runDelay(arg_17_0.nextStep, arg_17_0, 0.67)

		arg_17_0.selectIndex = nil
	end
end

function var_0_0.clickRole(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0.forceBagInfo[arg_18_1.x] and arg_18_0.forceBagInfo[arg_18_1.x].bagInfo

	if var_18_0 then
		local var_18_1 = var_18_0.heroId[arg_18_1.y]
		local var_18_2 = Activity174Config.instance:getRoleCo(var_18_1)

		if var_18_2 then
			local var_18_3 = {
				type = Activity174Enum.ItemTipType.Character,
				co = var_18_2
			}

			var_18_3.showMask = true

			Activity174Controller.instance:openItemTipView(var_18_3)
		end
	end
end

function var_0_0.clickCollection(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0.forceBagInfo[arg_19_1.x] and arg_19_0.forceBagInfo[arg_19_1.x].bagInfo

	if var_19_0 then
		local var_19_1 = var_19_0.itemId[arg_19_1.y]
		local var_19_2 = Activity174Config.instance:getCollectionCo(var_19_1)

		if var_19_2 then
			local var_19_3 = {
				type = Activity174Enum.ItemTipType.Collection,
				co = var_19_2
			}

			var_19_3.showMask = true

			Activity174Controller.instance:openItemTipView(var_19_3)
		end
	end
end

function var_0_0.nextStep(arg_20_0)
	local var_20_0 = Activity174Model.instance:getActInfo():getGameInfo()

	if var_20_0.state == Activity174Enum.GameState.ForceSelect then
		Activity174Controller.instance:openForcePickView(var_20_0:getForceBagsInfo())
	else
		Activity174Controller.instance:openGameView()
		arg_20_0:closeThis()
	end
end

return var_0_0
