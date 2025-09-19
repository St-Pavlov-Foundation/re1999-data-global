module("modules.logic.versionactivity2_8.dungeontaskstore.view.store.VersionActivity2_8StoreView", package.seeall)

local var_0_0 = class("VersionActivity2_8StoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._scrollstore = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_store")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_Content")
	arg_1_0._gostoreItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	arg_1_0._gostoregoodsitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_time")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, arg_4_0.onBuyGoodsSuccess, arg_4_0)
	arg_4_0:addEventCb(JumpController.instance, JumpEvent.BeforeJump, arg_4_0.closeThis, arg_4_0)
end

function var_0_0.onBuyGoodsSuccess(arg_5_0)
	arg_5_0:refreshStore()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	arg_7_0:refreshStore()
	arg_7_0:refreshTime()
end

function var_0_0.refreshStore(arg_8_0)
	VersionActivity2_8StoreListModel.instance:refreshStore()
end

function var_0_0.refreshTime(arg_9_0)
	local var_9_0 = ActivityModel.instance:getActivityInfo()[VersionActivity2_8DungeonTaskStoreController.instance:getModuleConfig().DungeonStore]:getRealEndTimeStamp() - ServerTime.now()

	arg_9_0._txttime.text = TimeUtil.SecondToActivityTimeFormat(var_9_0)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagebg:UnLoadImage()
end

return var_0_0
