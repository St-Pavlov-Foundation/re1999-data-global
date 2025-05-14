module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionFightEntry", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionFightEntry", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._rootPath = arg_1_1 or ""

	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._rootGo = gohelper.findChild(arg_2_0.viewGO, arg_2_0._rootPath)

	gohelper.setActive(arg_2_0._rootGo, true)

	arg_2_0._btncollection = gohelper.findChildButtonWithAudio(arg_2_0._rootGo, "#btn_collection")
	arg_2_0._txtcollectionnum = gohelper.findChildText(arg_2_0._rootGo, "#btn_collection/bg/#txt_collectionnum")
end

function var_0_0.addEvents(arg_3_0)
	if arg_3_0._btncollection then
		arg_3_0._btncollection:AddClickListener(arg_3_0._btncollectionOnClick, arg_3_0)
	end

	arg_3_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueInfo, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateCollectionsInfo, arg_3_0.updateCollectionNum, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	if arg_4_0._btncollection then
		arg_4_0._btncollection:RemoveClickListener()
	end

	arg_4_0:removeEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueInfo, arg_4_0.refreshUI, arg_4_0)
	arg_4_0:removeEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateCollectionsInfo, arg_4_0.updateCollectionNum, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshUI()
end

function var_0_0.refreshUI(arg_6_0)
	arg_6_0:updateCollectionNum()
end

function var_0_0.updateCollectionNum(arg_7_0)
	local var_7_0 = V1a6_CachotModel.instance:getRogueInfo()
	local var_7_1 = 0

	if var_7_0 then
		var_7_1 = var_7_0.collections and #var_7_0.collections or 0
	end

	arg_7_0._txtcollectionnum.text = var_7_1
end

function var_0_0.onClose(arg_8_0)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotCollectionBagView)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotCollectionOverView)
end

function var_0_0._btncollectionOnClick(arg_9_0)
	if not FightModel.instance:isStartFinish() then
		return
	end

	if V1a6_CachotModel.instance:getRogueInfo() then
		V1a6_CachotController.instance:openV1a6_CachotCollectionBagView({
			isCanEnchant = false
		})
	end
end

return var_0_0
