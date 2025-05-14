module("modules.logic.skin.view.SkinOffsetSkinItem", package.seeall)

local var_0_0 = class("SkinOffsetSkinItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0.txtskinname = gohelper.findChildText(arg_1_0.viewGO, "#txt_skinname")

	arg_1_0:addEventCb(SkinOffsetController.instance, SkinOffsetController.Event.OnSelectSkinChange, arg_1_0.refreshSelect, arg_1_0)

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

function var_0_0.onClick(arg_4_0)
	if arg_4_0.isSelect then
		return
	end

	SkinOffsetSkinListModel.instance:setSelectSkin(arg_4_0.mo.skinId)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.click = gohelper.getClick(arg_5_0.viewGO)

	arg_5_0.click:AddClickListener(arg_5_0.onClick, arg_5_0)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0.goselect, false)

	arg_6_0.txtskinname.text = arg_6_1.skinId .. "#" .. arg_6_1.skinName
	arg_6_0.mo = arg_6_1

	arg_6_0:refreshSelect()
end

function var_0_0.getMo(arg_7_0)
	return arg_7_0.mo
end

function var_0_0.refreshSelect(arg_8_0)
	arg_8_0.isSelect = SkinOffsetSkinListModel.instance:isSelect(arg_8_0.mo.skinId)

	gohelper.setActive(arg_8_0.goselect, arg_8_0.isSelect)
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0.click:RemoveClickListener()
end

return var_0_0
