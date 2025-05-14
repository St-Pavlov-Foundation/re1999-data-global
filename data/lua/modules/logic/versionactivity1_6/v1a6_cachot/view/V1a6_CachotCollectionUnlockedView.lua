module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionUnlockedView", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionUnlockedView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagelevelbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_levelbg")
	arg_1_0._simagetipsbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_tipsbg")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_info/#scroll_view")
	arg_1_0._gounlockeditem = gohelper.findChild(arg_1_0.viewGO, "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem")
	arg_1_0._simagecollection = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem/#simage_collection")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem/#go_container")
	arg_1_0._txtitem = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem/#go_container/#txt_item")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem/#txt_name")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btnquit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_quit")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#go_info")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnquit:AddClickListener(arg_2_0._btnquitOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnquit:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnquitOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._goScrollContent = gohelper.findChild(arg_6_0.viewGO, "#go_info/#scroll_view/Viewport/Content")
	arg_6_0._contentGrid = gohelper.onceAddComponent(arg_6_0._goScrollContent, typeof(UnityEngine.UI.GridLayoutGroup))
	arg_6_0._contentGrid.enabled = false
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	V1a6_CachotCollectionUnlockController.instance:onOpenView()
	arg_8_0:setInfoPos()
end

function var_0_0.setInfoPos(arg_9_0)
	local var_9_0 = V1a6_CachotCollectionUnLockListModel.instance:getCount()
	local var_9_1 = arg_9_0.viewContainer:getListScrollParam()
	local var_9_2 = var_9_0 > (var_9_1 and var_9_1.lineCount or 0)

	arg_9_0._contentGrid.enabled = not var_9_2
end

function var_0_0.onClose(arg_10_0)
	V1a6_CachotCollectionUnlockController.instance:onCloseView()
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
