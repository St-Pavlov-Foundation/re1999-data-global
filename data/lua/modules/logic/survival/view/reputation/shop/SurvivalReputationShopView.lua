module("modules.logic.survival.view.reputation.shop.SurvivalReputationShopView", package.seeall)

local var_0_0 = class("SurvivalReputationShopView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagebuilding = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/go_building/#simage_building")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "Left/go_building/#txt_name")
	arg_1_0._imagecamp = gohelper.findChildImage(arg_1_0.viewGO, "Left/go_building/#image_camp")
	arg_1_0._imagelevelbg = gohelper.findChildImage(arg_1_0.viewGO, "Left/go_building/#image_levelbg")
	arg_1_0._btnleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/go_building/#btn_left")
	arg_1_0._btnright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/go_building/#btn_right")
	arg_1_0._leftRedDot = gohelper.findChild(arg_1_0.viewGO, "Left/go_building/#leftRedDot")
	arg_1_0._rightRedDot = gohelper.findChild(arg_1_0.viewGO, "Left/go_building/#rightRedDot")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "Left/go_building/#txt_level")
	arg_1_0._txtcamp = gohelper.findChildText(arg_1_0.viewGO, "Left/go_building/#txt_camp")
	arg_1_0._imageprogresspre = gohelper.findChildImage(arg_1_0.viewGO, "Left/go_building/score/progress/#image_progress_pre")
	arg_1_0._imageprogress = gohelper.findChildImage(arg_1_0.viewGO, "Left/go_building/score/progress/#image_progress")
	arg_1_0._txtcurrent = gohelper.findChildText(arg_1_0.viewGO, "Left/go_building/score/#txt_current")
	arg_1_0._txttotal = gohelper.findChildText(arg_1_0.viewGO, "Left/go_building/score/#txt_total")
	arg_1_0._txtcondition = gohelper.findChildText(arg_1_0.viewGO, "Left/go_building/#txt_condition")
	arg_1_0._godetail = gohelper.findChild(arg_1_0.viewGO, "#go_detail")
	arg_1_0._goscrollcontent = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_shop/Viewport/#go_scroll_content")
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "Right/#go_topright")
	arg_1_0._txttag = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_topright/tag/#txt_tag")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0.survivalreputationshopitem = gohelper.findChild(arg_1_0.viewGO, "Right/scroll_shop/Viewport/#go_scroll_content/survivalreputationshopitem")

	gohelper.setActive(arg_1_0.survivalreputationshopitem, false)

	arg_1_0.playerViewGo = SLFramework.AnimatorPlayer.Get(arg_1_0.viewGO)
	arg_1_0.refreshFlow = FlowSequence.New()

	arg_1_0.refreshFlow:addWork(TimerWork.New(0.167))
	arg_1_0.refreshFlow:addWork(FunctionWork.New(arg_1_0.refresh, arg_1_0))

	arg_1_0.customItems = {}
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnleft, arg_2_0.onClickLeftArrow, arg_2_0)
	arg_2_0:addClickCb(arg_2_0._btnright, arg_2_0.onClickRightArrow, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_2_0.onShelterBagUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnClickTipsBtn, arg_2_0._onTipsClick, arg_2_0)
end

function var_0_0.onOpen(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)

	arg_3_0.weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	arg_3_0.reputationBuilds = arg_3_0.weekInfo:getReputationBuilds()
	arg_3_0.buildingId = arg_3_0.viewParam.buildingId
	arg_3_0.selectPos = arg_3_0:getSelectPos()

	arg_3_0:refresh()

	local var_3_0 = arg_3_0.viewContainer._viewSetting.otherRes.infoView
	local var_3_1 = arg_3_0:getResInst(var_3_0, arg_3_0._godetail)

	arg_3_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_3_1, SurvivalBagInfoPart)

	arg_3_0._infoPanel:updateMo(nil)
	arg_3_0._infoPanel:setCloseShow(true, arg_3_0.closeInfoView, arg_3_0)

	arg_3_0.selectSurvivalBagItem = nil
end

function var_0_0.onClose(arg_4_0)
	return
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0.refreshFlow:clearWork()
end

function var_0_0.onShelterBagUpdate(arg_6_0)
	arg_6_0:refreshCurrency()
end

function var_0_0.onClickLeftArrow(arg_7_0)
	if arg_7_0.selectPos > 1 then
		arg_7_0.selectPos = arg_7_0.selectPos - 1
		arg_7_0.buildingId = arg_7_0.reputationBuilds[arg_7_0.selectPos].id
	end

	arg_7_0.playerViewGo:Play("switchleft", nil, nil)
	arg_7_0.refreshFlow:clearWork()
	arg_7_0.refreshFlow:start()
end

function var_0_0.onClickRightArrow(arg_8_0)
	if arg_8_0.selectPos < #arg_8_0.reputationBuilds then
		arg_8_0.selectPos = arg_8_0.selectPos + 1
		arg_8_0.buildingId = arg_8_0.reputationBuilds[arg_8_0.selectPos].id
	end

	arg_8_0.playerViewGo:Play("switchright", nil, nil)
	arg_8_0.refreshFlow:clearWork()
	arg_8_0.refreshFlow:start()
end

function var_0_0.refresh(arg_9_0)
	arg_9_0.mo = arg_9_0.weekInfo:getBuildingInfo(arg_9_0.buildingId)
	arg_9_0.survivalShopMo = arg_9_0.mo.survivalReputationPropMo.survivalShopMo
	arg_9_0.shopId = arg_9_0.survivalShopMo.id
	arg_9_0.shopCfg = lua_survival_shop.configDict[arg_9_0.shopId]
	arg_9_0.buildingCfgId = arg_9_0.mo.buildingId
	arg_9_0.buildCfg = SurvivalConfig.instance:getBuildingConfig(arg_9_0.buildingCfgId, arg_9_0.mo.level)
	arg_9_0.survivalReputationPropMo = arg_9_0.mo.survivalReputationPropMo
	arg_9_0.prop = arg_9_0.survivalReputationPropMo.prop
	arg_9_0.reputationId = arg_9_0.prop.reputationId
	arg_9_0.reputationLevel = arg_9_0.prop.reputationLevel
	arg_9_0.reputationCfg = SurvivalConfig.instance:getReputationCfgById(arg_9_0.reputationId, arg_9_0.reputationLevel)
	arg_9_0.reputationExp = arg_9_0.prop.reputationExp
	arg_9_0.isMaxLevel = arg_9_0.survivalReputationPropMo:isMaxLevel()

	arg_9_0:refreshBuild()
	arg_9_0:refreshArrow()
	arg_9_0:refreshCurrency()
	arg_9_0:refreshItemList()
end

function var_0_0.refreshArrow(arg_10_0)
	gohelper.setActive(arg_10_0._btnleft, arg_10_0.selectPos > 1)
	gohelper.setActive(arg_10_0._btnright, arg_10_0.selectPos < #arg_10_0.reputationBuilds)

	if arg_10_0.selectPos > 1 then
		local var_10_0 = arg_10_0.reputationBuilds[arg_10_0.selectPos - 1]

		gohelper.setActive(arg_10_0._leftRedDot, var_10_0:getReputationShopRedDot() > 0)
	else
		gohelper.setActive(arg_10_0._leftRedDot, false)
	end

	if arg_10_0.selectPos < #arg_10_0.reputationBuilds then
		local var_10_1 = arg_10_0.reputationBuilds[arg_10_0.selectPos + 1]

		gohelper.setActive(arg_10_0._rightRedDot, var_10_1:getReputationShopRedDot() > 0)
	else
		gohelper.setActive(arg_10_0._rightRedDot, false)
	end
end

function var_0_0.refreshBuild(arg_11_0)
	arg_11_0._simagebuilding:LoadImage(arg_11_0.buildCfg.icon)

	arg_11_0._txtname.text = arg_11_0.buildCfg.name

	UISpriteSetMgr.instance:setSurvivalSprite(arg_11_0._imagecamp, arg_11_0.reputationCfg.icon .. "_1")

	arg_11_0._txtlevel.text = "Lv." .. arg_11_0.reputationLevel
	arg_11_0._txtcamp.text = arg_11_0.reputationCfg.name

	local var_11_0 = arg_11_0.survivalReputationPropMo:getLevelBkg()

	UISpriteSetMgr.instance:setSurvivalSprite2(arg_11_0._imagelevelbg, var_11_0)

	local var_11_1 = arg_11_0.survivalReputationPropMo:getLevelProgressBkg(true)

	UISpriteSetMgr.instance:setSurvivalSprite2(arg_11_0._imageprogresspre, var_11_1)

	local var_11_2 = arg_11_0.survivalReputationPropMo:getLevelProgressBkg()

	UISpriteSetMgr.instance:setSurvivalSprite2(arg_11_0._imageprogress, var_11_2)

	if arg_11_0.isMaxLevel then
		arg_11_0._imageprogress.fillAmount = 1
	else
		local var_11_3 = SurvivalConfig.instance:getReputationCost(arg_11_0.reputationId, arg_11_0.reputationLevel)
		local var_11_4 = arg_11_0.reputationExp / var_11_3

		arg_11_0._imageprogress.fillAmount = var_11_4
	end

	if arg_11_0.isMaxLevel then
		arg_11_0._txtcurrent.text = "--"
		arg_11_0._txttotal.text = "--"
	else
		local var_11_5 = SurvivalConfig.instance:getReputationCost(arg_11_0.reputationId, arg_11_0.reputationLevel)

		arg_11_0._txtcurrent.text = arg_11_0.reputationExp
		arg_11_0._txttotal.text = var_11_5
	end

	arg_11_0._txtcondition.text = arg_11_0.buildCfg.desc
end

function var_0_0.refreshCurrency(arg_12_0)
	local var_12_0 = arg_12_0.weekInfo:getBag(SurvivalEnum.ItemSource.Shelter):getItemCountPlus(SurvivalEnum.CurrencyType.Gold)

	arg_12_0._txttag.text = var_12_0
end

function var_0_0.refreshItemList(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = arg_13_0.survivalShopMo:getReputationItemMaxLevel()
	local var_13_2 = SurvivalShelterModel.instance:getWeekInfo().clientData
	local var_13_3 = var_13_2:getReputationShopUILevel(arg_13_0.shopId)

	for iter_13_0 = 1, var_13_1 do
		local var_13_4 = iter_13_0
		local var_13_5 = arg_13_0.survivalShopMo:isReputationShopLevelLock(var_13_4)
		local var_13_6 = {
			viewContainer = arg_13_0.viewContainer,
			survivalReputationPropMo = arg_13_0.survivalReputationPropMo,
			index = iter_13_0,
			reputationLevel = arg_13_0.reputationLevel,
			isPlayLockAnim = not var_13_5 and var_13_3 < var_13_4
		}

		table.insert(var_13_0, var_13_6)
	end

	local var_13_7 = #arg_13_0.customItems
	local var_13_8 = #var_13_0

	for iter_13_1 = 1, var_13_8 do
		local var_13_9 = var_13_0[iter_13_1]

		if var_13_7 < iter_13_1 then
			local var_13_10 = gohelper.clone(arg_13_0.survivalreputationshopitem, arg_13_0._goscrollcontent)

			gohelper.setActive(var_13_10, true)

			arg_13_0.customItems[iter_13_1] = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_10, SurvivalReputationShopItem)
		end

		arg_13_0.customItems[iter_13_1]:updateMo(var_13_9, arg_13_0)
	end

	var_13_2:setReputationShopUILevel(arg_13_0.shopId, arg_13_0.reputationLevel)
	var_13_2:saveDataToServer()
end

function var_0_0.getSelectPos(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.reputationBuilds) do
		if iter_14_1.id == arg_14_0.buildingId then
			return iter_14_0
		end
	end
end

function var_0_0.showInfoPanel(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	if arg_15_0.selectSurvivalBagItem then
		arg_15_0.selectSurvivalBagItem:setIsSelect(false)
	end

	arg_15_0.selectSurvivalBagItem = arg_15_1

	arg_15_0.selectSurvivalBagItem:setIsSelect(true)
	arg_15_0._infoPanel:setShopData(arg_15_3, arg_15_4)
	arg_15_0._infoPanel:updateMo(arg_15_2, {
		hideBuy = arg_15_5
	})
end

function var_0_0.closeInfoView(arg_16_0)
	arg_16_0._infoPanel:updateMo(nil)

	if arg_16_0.selectSurvivalBagItem then
		arg_16_0.selectSurvivalBagItem:setIsSelect(false)

		arg_16_0.selectSurvivalBagItem = nil
	end
end

function var_0_0._onTipsClick(arg_17_0)
	arg_17_0:closeInfoView()
end

return var_0_0
