module("modules.logic.dungeon.view.map.DungeonMapChapterLineItem", package.seeall)

local var_0_0 = class("DungeonMapChapterLineItem", BaseChildView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gochoiceicon = gohelper.findChild(arg_1_0.viewGO, "#go_choiceicon")
	arg_1_0._simageicon1 = gohelper.findChildImage(arg_1_0.viewGO, "#go_choiceicon/#simage_icon1")
	arg_1_0._gonormalicon = gohelper.findChild(arg_1_0.viewGO, "#go_normalicon")
	arg_1_0._simageicon2 = gohelper.findChildImage(arg_1_0.viewGO, "#go_normalicon/#simage_icon2")
	arg_1_0._golockicon = gohelper.findChild(arg_1_0.viewGO, "#go_lockicon")
	arg_1_0._simageicon3 = gohelper.findChildImage(arg_1_0.viewGO, "#go_lockicon/#simage_icon3")

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

function var_0_0._onClick(arg_4_0)
	if arg_4_0._isSelect then
		return
	end

	if DungeonModel.instance.chapterBgTweening then
		return
	end

	if arg_4_0._isLock then
		if arg_4_0._lockCode == -1 then
			GameFacade.showToast(ToastEnum.DungeonChapterLine1)
		elseif arg_4_0._lockCode == -2 then
			-- block empty
		elseif arg_4_0._lockCode == -3 then
			GameFacade.showToast(ToastEnum.DungeonChapterLine3)
		elseif arg_4_0._lockCode == -4 and arg_4_0._lockToast then
			GameFacade.showToast(arg_4_0._lockToast, arg_4_0._lockToastParam)
		end

		return
	end

	if not arg_4_0._openTimeValid then
		GameFacade.showToast(ToastEnum.DungeonResChapter, arg_4_0._config.name)

		return
	end

	DungeonModel.instance:changeCategory(arg_4_0._config.type, false)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnChangeChapter, arg_4_0._config.id)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._click = gohelper.getClickWithAudio(arg_5_0.viewGO, AudioEnum.UI.UI_checkpoint_detailed_tabs_click)

	arg_5_0._click:AddClickListener(arg_5_0._onClick, arg_5_0)
end

function var_0_0.updateStatus(arg_6_0)
	arg_6_0:onSelect(arg_6_0._config.id == DungeonModel.instance.curLookChapterId)
end

function var_0_0.onSelect(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._gochoiceicon, arg_7_0._openTimeValid and arg_7_1)
	gohelper.setActive(arg_7_0._gonormalicon, arg_7_0._openTimeValid and not arg_7_1)
	gohelper.setActive(arg_7_0._golockicon, not arg_7_0._openTimeValid)
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0._config = arg_8_0.viewParam.config
	arg_8_0._isLock, arg_8_0._lockCode, arg_8_0._lockToast, arg_8_0._lockToastParam = DungeonModel.instance:chapterIsLock(arg_8_0._config.id)
	arg_8_0._openTimeValid = DungeonModel.instance:getChapterOpenTimeValid(arg_8_0._config)

	local var_8_0 = "bg_fuben_wenzi_" .. arg_8_0.viewParam.index

	if arg_8_0._openTimeValid then
		UISpriteSetMgr.instance:setDungeonNavigationSprite(arg_8_0._simageicon1, var_8_0)
		UISpriteSetMgr.instance:setDungeonNavigationSprite(arg_8_0._simageicon2, var_8_0)
	else
		UISpriteSetMgr.instance:setDungeonNavigationSprite(arg_8_0._simageicon3, var_8_0 .. "_dis")
	end
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:onUpdateParam()
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._click:RemoveClickListener()
end

return var_0_0
