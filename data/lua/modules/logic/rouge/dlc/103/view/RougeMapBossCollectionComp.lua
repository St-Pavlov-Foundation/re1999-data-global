module("modules.logic.rouge.dlc.103.view.RougeMapBossCollectionComp", package.seeall)

local var_0_0 = class("RougeMapBossCollectionComp", BaseViewExtended)

function var_0_0.definePrefabUrl(arg_1_0)
	arg_1_0:setPrefabUrl("ui/viewres/rouge/dlc/103/rougedistortruleview.prefab")
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._gonormal = gohelper.findChild(arg_2_0.viewGO, "Bg/normal")
	arg_2_0._gohard = gohelper.findChild(arg_2_0.viewGO, "Bg/hard")
	arg_2_0._gocollection = gohelper.findChild(arg_2_0.viewGO, "#go_collection")
	arg_2_0._gocollectionitem = gohelper.findChild(arg_2_0.viewGO, "#go_collection/#go_collectionitem")
	arg_2_0._btnfresh = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_fresh")
	arg_2_0._txtrule = gohelper.findChildText(arg_2_0.viewGO, "RuleView/Viewport/Content/#txt_rule")
	arg_2_0._gopic = gohelper.findChild(arg_2_0.PARENT_VIEW.viewGO, "#go_layer_right/#go_pic")
	arg_2_0._gofreshnormal = gohelper.findChild(arg_2_0.viewGO, "fresh_normal")
	arg_2_0._gofreshhard = gohelper.findChild(arg_2_0.viewGO, "fresh_hard")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnfresh:AddClickListener(arg_3_0._btnfreshOnClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnfresh:RemoveClickListener()
end

function var_0_0._btnfreshOnClick(arg_5_0)
	if not arg_5_0._selectLayerId or not arg_5_0._canFreshMapRule then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.RefreshRougeMapRule)

	local var_5_0 = arg_5_0._layerChoiceInfo and arg_5_0._layerChoiceInfo:getMapRuleCo()
	local var_5_1 = var_5_0 and var_5_0.type

	gohelper.setActive(arg_5_0._gofreshnormal, var_5_1 == RougeDLCEnum103.MapRuleType.Normal)
	gohelper.setActive(arg_5_0._gofreshhard, var_5_1 == RougeDLCEnum103.MapRuleType.Hard)

	local var_5_2 = RougeModel.instance:getSeason()

	RougeRpc.instance:sendRougeRefreshMapRuleRequest(var_5_2, arg_5_0._selectLayerId)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._collectionItemTab = arg_6_0:getUserDataTb_()
	arg_6_0._gofresh_light = gohelper.findChild(arg_6_0.viewGO, "#btn_fresh/light")
	arg_6_0._gofresh_dark = gohelper.findChild(arg_6_0.viewGO, "#btn_fresh/dark")

	arg_6_0:addEventCb(RougeMapController.instance, RougeMapEvent.onSelectLayerChange, arg_6_0.onSelectLayerChange, arg_6_0)
	arg_6_0:addEventCb(RougeMapController.instance, RougeMapEvent.onChangeMapInfo, arg_6_0.onChangeMapInfo, arg_6_0)
	arg_6_0:addEventCb(RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, arg_6_0.onChangeMapInfo, arg_6_0)
	arg_6_0:addEventCb(RougeMapController.instance, RougeMapEvent.onPathSelectMapFocusDone, arg_6_0.onChangeMapInfo, arg_6_0)
end

function var_0_0.onOpen(arg_7_0)
	if not RougeMapModel.instance:isPathSelect() then
		return
	end

	arg_7_0:initData(RougeMapModel.instance:getSelectLayerId())
	arg_7_0:refresh()
end

function var_0_0.initData(arg_8_0, arg_8_1)
	arg_8_0._selectLayerId = arg_8_1
	arg_8_0._layerChoiceInfo = RougeMapModel.instance:getLayerChoiceInfo(arg_8_0._selectLayerId)
	arg_8_0._mapRuleCanFreshNum = arg_8_0._layerChoiceInfo and arg_8_0._layerChoiceInfo:getMapRuleCanFreshNum()
	arg_8_0._canFreshMapRule = arg_8_0._mapRuleCanFreshNum and arg_8_0._mapRuleCanFreshNum > 0
	arg_8_0._isPathSelect = RougeMapModel.instance:isPathSelect()
end

function var_0_0.refresh(arg_9_0)
	gohelper.setActive(arg_9_0._gopic, not arg_9_0._isPathSelect)

	if not arg_9_0._isPathSelect then
		return
	end

	arg_9_0:refreshFreshBtn()
	arg_9_0:refreshMapRuleInfos()
	arg_9_0:refreshCollections()
end

function var_0_0.refreshFreshBtn(arg_10_0)
	gohelper.setActive(arg_10_0._gofresh_light, arg_10_0._canFreshMapRule)
	gohelper.setActive(arg_10_0._gofresh_dark, not arg_10_0._canFreshMapRule)
end

function var_0_0.refreshMapRuleInfos(arg_11_0)
	local var_11_0 = arg_11_0._layerChoiceInfo and arg_11_0._layerChoiceInfo:getMapRuleCo()
	local var_11_1 = var_11_0 and var_11_0.type
	local var_11_2 = var_11_0 and var_11_0.desc or ""

	arg_11_0._txtrule.text = SkillHelper.buildDesc(var_11_2)

	SkillHelper.addHyperLinkClick(arg_11_0._txtrule)
	gohelper.setActive(arg_11_0._gonormal, var_11_1 == RougeDLCEnum103.MapRuleType.Normal)
	gohelper.setActive(arg_11_0._gohard, var_11_1 == RougeDLCEnum103.MapRuleType.Hard)
end

function var_0_0.refreshCollections(arg_12_0)
	arg_12_0._collectionCfgIds = arg_12_0._layerChoiceInfo and arg_12_0._layerChoiceInfo:getCurLayerCollection()

	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._collectionCfgIds or {}) do
		local var_12_1 = arg_12_0:_getOrCreateCollectionItem(iter_12_0)
		local var_12_2 = RougeCollectionConfig.instance:getCollectionCfg(iter_12_1)
		local var_12_3 = RougeCollectionHelper.getCollectionIconUrl(iter_12_1)

		var_12_1.simageicon:LoadImage(var_12_3)

		local var_12_4 = var_12_2 and var_12_2.showRare

		UISpriteSetMgr.instance:setRougeSprite(var_12_1.imagebg, "rouge_episode_collectionbg_" .. tostring(var_12_4))
		gohelper.setActive(var_12_1.viewGO, true)

		var_12_0[var_12_1] = true
	end

	for iter_12_2, iter_12_3 in pairs(arg_12_0._collectionItemTab) do
		if not var_12_0[iter_12_3] then
			gohelper.setActive(iter_12_3.viewGO, false)
		end
	end
end

function var_0_0._getOrCreateCollectionItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._collectionItemTab[arg_13_1]

	if not var_13_0 then
		var_13_0 = arg_13_0:getUserDataTb_()
		var_13_0.viewGO = gohelper.cloneInPlace(arg_13_0._gocollectionitem, "collection_" .. arg_13_1)
		var_13_0.imagebg = gohelper.findChildImage(var_13_0.viewGO, "#image_bg")
		var_13_0.simageicon = gohelper.findChildSingleImage(var_13_0.viewGO, "#simage_collection")
		var_13_0.btnclick = gohelper.findChildButtonWithAudio(var_13_0.viewGO, "#btn_click")

		var_13_0.btnclick:AddClickListener(arg_13_0._btncollectionOnClick, arg_13_0, arg_13_1)

		arg_13_0._collectionItemTab[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0._btncollectionOnClick(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._collectionCfgIds[arg_14_1]

	if not var_14_0 then
		return
	end

	local var_14_1 = {
		interactable = false,
		collectionCfgId = var_14_0,
		viewPosition = RougeEnum.CollectionTipPos.MapRule
	}

	RougeController.instance:openRougeCollectionTipView(var_14_1)
end

function var_0_0._releaseAllCollectionItems(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._collectionItemTab) do
		iter_15_1.simageicon:UnLoadImage()
		iter_15_1.btnclick:RemoveClickListener()
	end
end

function var_0_0.onSelectLayerChange(arg_16_0, arg_16_1)
	arg_16_0:initData(arg_16_1)
	gohelper.setActive(arg_16_0._gofreshnormal, false)
	gohelper.setActive(arg_16_0._gofreshhard, false)
	TaskDispatcher.cancelTask(arg_16_0.refresh, arg_16_0)
	TaskDispatcher.runDelay(arg_16_0.refresh, arg_16_0, RougeMapEnum.WaitMapRightRefreshTime)
end

function var_0_0.onChangeMapInfo(arg_17_0)
	if not RougeMapModel.instance:isPathSelect() then
		return
	end

	arg_17_0:initData(RougeMapModel.instance:getSelectLayerId())
	arg_17_0:refresh()
end

function var_0_0.onClose(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0.refresh, arg_18_0)
	arg_18_0:_releaseAllCollectionItems()
end

return var_0_0
