module("modules.logic.versionactivity2_2.lopera.view.LoperaGoodsItem", package.seeall)

local var_0_0 = class("LoperaGoodsItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#image_Icon")
	arg_1_0._iconBtn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#image_Icon")
	arg_1_0._numText = gohelper.findChildText(arg_1_0.viewGO, "image_NumBG/#txt_Num")
	arg_1_0._goNewFlag = gohelper.findChild(arg_1_0.viewGO, "#go_New")
	arg_1_0._canvasGroup = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	if arg_2_0._iconBtn then
		arg_2_0._iconBtn:AddClickListener(arg_2_0._iconBtnClick, arg_2_0)
	end
end

function var_0_0.removeEvents(arg_3_0)
	if arg_3_0._iconBtn then
		arg_3_0._iconBtn:RemoveClickListener()
	end
end

function var_0_0._iconBtnClick(arg_4_0)
	if arg_4_0._itemCount > 0 then
		gohelper.setActive(arg_4_0._goNewFlag, false)
	end

	LoperaController.instance:dispatchEvent(LoperaEvent.GoodItemClick, arg_4_0._idx)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	arg_8_0:setItemId(arg_8_1.itemId)

	if (arg_8_1.quantity or arg_8_1.getQuantity) and not arg_8_1.quantity then
		local var_8_0 = arg_8_1:getQuantity()
	end
end

function var_0_0.onUpdateData(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	arg_9_0._cfg = arg_9_1
	arg_9_0._idx = arg_9_3
	arg_9_0._itemCount = arg_9_2
	arg_9_0._numText.text = arg_9_2

	local var_9_0 = false

	if arg_9_4 and arg_9_4.showNewFlag then
		var_9_0 = GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_2LoperaItemNewFlag .. arg_9_1.itemId, 0) == 0 and arg_9_2 > 0
	end

	gohelper.setActive(arg_9_0._goNewFlag, var_9_0)

	if var_9_0 then
		GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Version2_2LoperaItemNewFlag .. arg_9_0._cfg.itemId, 1)
	end

	arg_9_0:_refreshIcon(arg_9_1.itemId, arg_9_1)

	if arg_9_0._canvasGroup then
		arg_9_0._canvasGroup.alpha = arg_9_2 > 0 and 1 or 0.5
	end
end

function var_0_0.setItemId(arg_10_0, arg_10_1)
	arg_10_0._itemId = arg_10_1

	arg_10_0:_refreshIcon(arg_10_1)
end

function var_0_0.setShowCount(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._isShow ~= arg_11_1 then
		arg_11_0._isShow = arg_11_1

		gohelper.setActive(arg_11_0._gocount, arg_11_1)
	end

	if arg_11_2 == true then
		arg_11_0._imagecountBG.enabled = true
	elseif arg_11_2 == false then
		arg_11_0._imagecountBG.enabled = false
	end
end

function var_0_0.setCountStr(arg_12_0, arg_12_1)
	arg_12_0._txtcount.text = arg_12_1
end

function var_0_0._refreshIcon(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2 = arg_13_2 or Activity168Config.instance:getGameItemCfg(VersionActivity2_2Enum.ActivityId.Lopera, arg_13_1)

	UISpriteSetMgr.instance:setLoperaItemSprite(arg_13_0._imageicon, arg_13_2.icon, false)
end

function var_0_0.onDestroyView(arg_14_0)
	return
end

var_0_0.prefabPath = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_goodsitem_temporary.prefab"
var_0_0.prefabPath2 = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_goodsitem2_temporary.prefab"
var_0_0.prefabPath3 = "ui/viewres/versionactivity_2_2/v2a2_lopera/v2a2_lopera_goodsitem3_temporary.prefab"

return var_0_0
