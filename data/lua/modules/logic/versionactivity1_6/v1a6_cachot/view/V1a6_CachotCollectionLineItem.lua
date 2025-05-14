module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionLineItem", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionLineItem", MixScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._golayout = gohelper.findChild(arg_1_1, "#go_layout")
	arg_1_0._gotop = gohelper.findChild(arg_1_1, "#go_top")
	arg_1_0._imagetitleicon = gohelper.findChildImage(arg_1_1, "#go_top/#image_titleicon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._mo = arg_4_1

	arg_4_0:_initCloneCollectionItemRes()
	arg_4_0:refreshUI()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._animator = gohelper.onceAddComponent(arg_5_0.viewGO, gohelper.Type_Animator)

	V1a6_CachotCollectionController.instance:registerCallback(V1a6_CachotEvent.OnSwitchCategory, arg_5_0._resetAnimPlayState, arg_5_0)
end

function var_0_0.refreshUI(arg_6_0)
	gohelper.setActive(arg_6_0._gotop, arg_6_0._mo._isTop)
	UISpriteSetMgr.instance:setV1a6CachotSprite(arg_6_0._imagetitleicon, "v1a6_cachot_icon_collectionsort" .. arg_6_0._mo.collectionType)
	gohelper.CreateObjList(arg_6_0, arg_6_0._onUpdateCollectionItem, arg_6_0._mo.collectionList, arg_6_0._golayout, arg_6_0._cloneCollectionItemRes, V1a6_CachotCollectionItem)
	arg_6_0:_playAnim()
end

function var_0_0._onUpdateCollectionItem(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	gohelper.setActive(arg_7_1.viewGO, arg_7_2 ~= nil)

	if arg_7_2 then
		arg_7_1:onUpdateMO(arg_7_2, arg_7_0._index)
	end
end

function var_0_0._initCloneCollectionItemRes(arg_8_0)
	if not arg_8_0._cloneCollectionItemRes then
		local var_8_0 = ViewMgr.instance:getSetting(arg_8_0._view.viewName)

		arg_8_0._cloneCollectionItemRes = arg_8_0._view.viewContainer:getRes(var_8_0.otherRes[1])
	end
end

function var_0_0._playAnim(arg_9_0)
	if arg_9_0._mo._isTop and not arg_9_0._isPlayOpenAnimFinished then
		arg_9_0._animator:Play("open", 0, 0)

		arg_9_0._isPlayOpenAnimFinished = true
	else
		arg_9_0._animator:Play("idle", 0, 0)
	end
end

function var_0_0._resetAnimPlayState(arg_10_0)
	arg_10_0._isPlayOpenAnimFinished = false

	arg_10_0:_playAnim()
end

function var_0_0.onDestroy(arg_11_0)
	arg_11_0._cloneCollectionItemRes = nil

	V1a6_CachotCollectionController.instance:unregisterCallback(V1a6_CachotEvent.OnSwitchCategory, arg_11_0._resetAnimPlayState, arg_11_0)
end

return var_0_0
