module("modules.logic.dungeon.view.DungeonMapOtherBtnView", package.seeall)

local var_0_0 = class("DungeonMapOtherBtnView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotopright = gohelper.findChild(arg_1_0.viewGO, "#go_topright")
	arg_1_0._btnequipstore = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_topright/#btn_equipstore")
	arg_1_0._txtequipstore = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#btn_equipstore/#txt_equipstore")
	arg_1_0._txtequipstoreen = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#btn_equipstore/#txt_equipstoreen")
	arg_1_0._gorolestory = gohelper.findChild(arg_1_0.viewGO, "#go_rolestory")
	arg_1_0._btnrolestory = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolestory/#btn_review")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnequipstore:AddClickListener(arg_2_0._btnEquipStoreOnClick, arg_2_0)
	arg_2_0._btnrolestory:AddClickListener(arg_2_0._btnRoleStoryOnClick, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnequipstore:RemoveClickListener()
	arg_3_0._btnrolestory:RemoveClickListener()
end

function var_0_0._btnRoleStoryOnClick(arg_4_0)
	RoleStoryController.instance:openReviewView()
end

function var_0_0._btnEquipStoreOnClick(arg_5_0)
	StoreController.instance:openStoreView(StoreEnum.StoreId.SummonEquipExchange)
end

function var_0_0._editableInitView(arg_6_0)
	return
end

function var_0_0._onOpenView(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.DungeonMapLevelView then
		arg_7_0:refreshUI()
	end
end

function var_0_0._onCloseView(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.DungeonMapLevelView then
		arg_8_0:refreshUI()
	end
end

function var_0_0.onUpdateParam(arg_9_0)
	arg_9_0:refreshUI()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._txtequipstore.text = luaLang("equip_store_name")
	arg_10_0._txtequipstoreen.text = "PSYCHUBE SHOP"

	arg_10_0:refreshUI()
end

function var_0_0.refreshUI(arg_11_0)
	arg_11_0.isEquipDungeon = DungeonModel.instance.curChapterType == DungeonEnum.ChapterType.Equip

	gohelper.setActive(arg_11_0._gotopright, arg_11_0.isEquipDungeon and not ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView))
	gohelper.setActive(arg_11_0._gorolestory, not ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) and DungeonModel.instance:chapterListIsRoleStory() and RoleStoryModel.instance:isShowReplayStoryBtn())
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
