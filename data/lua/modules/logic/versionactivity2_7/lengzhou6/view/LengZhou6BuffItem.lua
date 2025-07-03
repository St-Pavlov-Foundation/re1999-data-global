module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6BuffItem", package.seeall)

local var_0_0 = class("LengZhou6BuffItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagebuff = gohelper.findChildImage(arg_1_0.viewGO, "#image_buff")
	arg_1_0._txtbuffValue = gohelper.findChildText(arg_1_0.viewGO, "#image_buff/#txt_buffValue")
	arg_1_0._goclick = gohelper.findChild(arg_1_0.viewGO, "#image_buff/#go_click")

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
	arg_4_0._click = SLFramework.UGUI.UIClickListener.Get(arg_4_0._goclick)

	arg_4_0._click:AddClickListener(arg_4_0._onClick, arg_4_0)
end

function var_0_0._onClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_5_0._buff then
		LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.OnClickBuff, arg_5_0._buff._configId)
	end
end

function var_0_0.updateBuffItem(arg_6_0, arg_6_1)
	arg_6_0._buff = arg_6_1

	if arg_6_0._buff ~= nil then
		local var_6_0 = arg_6_0._buff.config.icon

		UISpriteSetMgr.instance:setBuffSprite(arg_6_0._imagebuff, var_6_0)

		local var_6_1 = arg_6_0._buff:getLayerCount()

		arg_6_0._txtbuffValue.text = var_6_1

		gohelper.setActive(arg_6_0.viewGO, var_6_1 > 0)
	else
		gohelper.setActive(arg_6_0.viewGO, false)
	end
end

function var_0_0.changeParent(arg_7_0, arg_7_1)
	arg_7_0.viewGO.transform.parent = arg_7_1.transform
end

function var_0_0.onDestroyView(arg_8_0)
	if arg_8_0._click then
		arg_8_0._click:RemoveClickListener()

		arg_8_0._click = nil
	end
end

return var_0_0
