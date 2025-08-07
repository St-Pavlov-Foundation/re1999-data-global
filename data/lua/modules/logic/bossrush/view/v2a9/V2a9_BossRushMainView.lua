module("modules.logic.bossrush.view.v2a9.V2a9_BossRushMainView", package.seeall)

local var_0_0 = class("V2a9_BossRushMainView", V1a4_BossRushMainView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "LimitTime/#txt_LimitTime")
	arg_1_0._btnStore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Store/#btn_Store")
	arg_1_0._simageProp = gohelper.findChildSingleImage(arg_1_0.viewGO, "Store/#btn_Store/#simage_Prop")
	arg_1_0._txtNum = gohelper.findChildText(arg_1_0.viewGO, "Store/#btn_Store/#txt_Num")
	arg_1_0._btnAchievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "TopRight/#btn_Achievement")
	arg_1_0._txtAchievement = gohelper.findChildText(arg_1_0.viewGO, "TopRight/#txt_Achievement")
	arg_1_0._goStoreTip = gohelper.findChild(arg_1_0.viewGO, "Store/image_Tips")
	arg_1_0._txtStore = gohelper.findChildText(arg_1_0.viewGO, "Store/#btn_Store/txt_Store")
	arg_1_0._txtActDesc = gohelper.findChildText(arg_1_0.viewGO, "txtDescr")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0)
end

function var_0_0._onCloseViewFinish(arg_4_0, arg_4_1)
	if arg_4_1 == ViewName.VersionActivity2_9DungeonMapView or arg_4_1 == ViewName.OdysseyDungeonView then
		local var_4_0 = BossRushModel.instance:getStagesInfo()

		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			local var_4_1 = arg_4_0._itemList[iter_4_0] or arg_4_0:_create_V2a9_BossRushMainItem()

			var_4_1._index = iter_4_0

			var_4_1:returnPlayAnim(true)

			arg_4_0._itemList[iter_4_0] = var_4_1
		end
	end
end

function var_0_0._editableInitView(arg_5_0)
	var_0_0.super._editableInitView(arg_5_0)

	arg_5_0._goContent = gohelper.findChild(arg_5_0.viewGO, "StageItems")

	V1a6_BossRush_StoreModel.instance:readAllStoreGroupNewData()
	V1a6_BossRush_StoreModel.instance:checkStoreNewGoods()
	ActivityEnterMgr.instance:enterActivity(BossRushConfig.instance:getActivityId())
end

function var_0_0._create_V2a9_BossRushMainItem(arg_6_0)
	local var_6_0 = V2a9_BossRushMainItem
	local var_6_1 = arg_6_0.viewContainer:getResInst(BossRushModel.instance:getActivityMainViewItemPath(), arg_6_0._goContent, var_6_0.__cname)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_6_1, var_6_0)
end

function var_0_0._initItemList(arg_7_0, arg_7_1)
	if arg_7_0._itemList then
		return
	end

	arg_7_0._itemList = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_0 = arg_7_0:_create_V2a9_BossRushMainItem()

		var_7_0._index = iter_7_0

		var_7_0:setData(iter_7_1, true)
		table.insert(arg_7_0._itemList, var_7_0)
	end
end

function var_0_0._refreshRight(arg_8_0)
	local var_8_0 = BossRushModel.instance:getStagesInfo()

	arg_8_0:_initItemList(var_8_0)
end

function var_0_0._refreshLeftBottom(arg_9_0)
	return
end

return var_0_0
