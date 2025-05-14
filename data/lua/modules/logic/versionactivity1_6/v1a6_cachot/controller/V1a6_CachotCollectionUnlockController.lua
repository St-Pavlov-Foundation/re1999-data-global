module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotCollectionUnlockController", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionUnlockController", BaseController)

function var_0_0.onReceiveUnlockCollections(arg_1_0, arg_1_1)
	V1a6_CachotCollectionUnLockListModel.instance:saveUnlockCollectionList(arg_1_1)

	if arg_1_0:checkIsCurrentInCachotMainView() then
		arg_1_0:checkOpenUnlockedView()
	elseif not arg_1_0._registerEvent then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_1_0.checkOpenView, arg_1_0)
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_1_0.checkCloseView, arg_1_0)

		arg_1_0._registerEvent = true
	end
end

function var_0_0.checkIsCurrentInCachotMainView(arg_2_0)
	return ViewMgr.instance:isOpen(ViewName.V1a6_CachotMainView)
end

function var_0_0.checkOpenView(arg_3_0, arg_3_1)
	if arg_3_1 == ViewName.V1a6_CachotMainView then
		arg_3_0:checkOpenUnlockedView()
	end
end

function var_0_0.checkCloseView(arg_4_0)
	if arg_4_0:checkIsCurrentInCachotMainView() then
		arg_4_0:checkOpenUnlockedView()
	end
end

function var_0_0.checkOpenUnlockedView(arg_5_0)
	if V1a6_CachotCollectionUnLockListModel.instance:getNewUnlockCollectionsCount() > 0 then
		V1a6_CachotController.instance:openV1a6_CachotCollectionUnlockedView()
	end
end

function var_0_0.onOpenView(arg_6_0)
	V1a6_CachotCollectionUnLockListModel.instance:onInitData()
end

function var_0_0.onCloseView(arg_7_0)
	V1a6_CachotCollectionUnLockListModel.instance:release()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_7_0.checkOpenView, arg_7_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, arg_7_0.checkCloseView, arg_7_0)

	arg_7_0._registerEvent = false
end

var_0_0.instance = var_0_0.New()

return var_0_0
