module("modules.logic.versionactivity1_4.act130.view.Activity130CollectItem", package.seeall)

local var_0_0 = class("Activity130CollectItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._imageitembg = gohelper.findChildImage(arg_1_0._go, "image_ItemBG")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0._go, "#image_Icon")
	arg_1_0._txtIndex = gohelper.findChildText(arg_1_0._go, "#txt_Num")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0._go, "#txt_Item")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0._go, "#txt_Type")

	arg_1_0:addEventListeners()
end

function var_0_0.setItem(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._config = arg_2_1
	arg_2_0._index = arg_2_2

	gohelper.setActive(arg_2_0._go, true)
	arg_2_0:_refreshItem()
end

function var_0_0._refreshItem(arg_3_0)
	arg_3_0._txtIndex.text = string.format("%02d", arg_3_0._index)

	local var_3_0 = Activity130Model.instance:getCurEpisodeId()
	local var_3_1 = Activity130Model.instance:getCollects(var_3_0)[arg_3_0._index]

	if not Activity130Model.instance:isCollectUnlock(var_3_0, var_3_1) then
		arg_3_0._txtDesc.text = "?????"

		UISpriteSetMgr.instance:setV1a4Role37Sprite(arg_3_0._imageicon, "v1a4_role37_collectitemiconempty")

		return
	end

	arg_3_0._txtDesc.text = arg_3_0._config.operDesc
	arg_3_0._txtTitle.text = arg_3_0._config.name

	UISpriteSetMgr.instance:setV1a4Role37Sprite(arg_3_0._imageicon, arg_3_0._config.shapegetImg)
end

function var_0_0.hideItem(arg_4_0)
	gohelper.setActive(arg_4_0._go, false)
end

function var_0_0.addEventListeners(arg_5_0)
	return
end

function var_0_0.removeEventListeners(arg_6_0)
	return
end

function var_0_0._btnclickOnClick(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	return
end

function var_0_0.onSelect(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0:removeEventListeners()
end

return var_0_0
