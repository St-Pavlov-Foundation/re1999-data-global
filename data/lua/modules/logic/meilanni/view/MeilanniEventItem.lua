module("modules.logic.meilanni.view.MeilanniEventItem", package.seeall)

local var_0_0 = class("MeilanniEventItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "icon/#image_icon")
	arg_1_0._goinfo = gohelper.findChild(arg_1_0.viewGO, "#go_info")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "#go_info/#txt_title")
	arg_1_0._imagephoto = gohelper.findChildImage(arg_1_0.viewGO, "#image_photo")

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
	arg_4_0._click = SLFramework.UGUI.UIClickListener.Get(arg_4_0.viewGO)
	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.setPhotoVisible(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_0._imagephoto.gameObject, arg_5_0._showModel and arg_5_1)
end

function var_0_0.playAnim(arg_6_0, arg_6_1)
	arg_6_0._animator:Play(arg_6_1)
end

function var_0_0._editableAddEvents(arg_7_0)
	arg_7_0._click:AddClickListener(arg_7_0._onClick, arg_7_0)
end

function var_0_0._editableRemoveEvents(arg_8_0)
	arg_8_0._click:RemoveClickListener()
end

function var_0_0._onClick(arg_9_0)
	if arg_9_0._clickEnabled == false then
		MeilanniController.instance:dispatchEvent(MeilanniEvent.resetDialogPos)

		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_story_open)
	MeilanniController.instance:dispatchEvent(MeilanniEvent.clickEventItem, arg_9_0)
end

function var_0_0.isSelected(arg_10_0)
	return arg_10_0._isSelected
end

function var_0_0.setSelected(arg_11_0, arg_11_1)
	arg_11_0._isSelected = arg_11_1

	if arg_11_1 then
		local var_11_0 = gohelper.findChild(arg_11_0.viewGO, "icon/glow/glow_yellow")
		local var_11_1 = gohelper.findChild(arg_11_0.viewGO, "icon/glow/glow_red")

		gohelper.setActive(var_11_0, arg_11_0._config.type ~= 1)
		gohelper.setActive(var_11_1, arg_11_0._config.type == 1)
		arg_11_0:playAnim("select")
	else
		arg_11_0:playAnim("unselect")
	end
end

function var_0_0.setClickEnabled(arg_12_0, arg_12_1)
	arg_12_0._clickEnabled = arg_12_1
end

function var_0_0.setGray(arg_13_0, arg_13_1)
	if arg_13_0._speicalType then
		return
	end

	UISpriteSetMgr.instance:setMeilanniSprite(arg_13_0._imageicon, arg_13_1 and "bg_tanhao_1" or "bg_tanhaohui")
end

function var_0_0.isSpecialType(arg_14_0)
	return arg_14_0._speicalType
end

function var_0_0.updateInfo(arg_15_0, arg_15_1)
	arg_15_0._info = arg_15_1
	arg_15_0._eventId = arg_15_0._info.eventId
	arg_15_0._config = lua_activity108_event.configDict[arg_15_0._eventId]

	local var_15_0 = string.splitToNumber(arg_15_0._config.pos, "#")
	local var_15_1 = var_15_0[1] or 0
	local var_15_2 = var_15_0[2] or 0

	transformhelper.setLocalPos(arg_15_0.viewGO.transform, var_15_1, var_15_2, 0)

	arg_15_0._speicalType = arg_15_0._config.type == 1

	UISpriteSetMgr.instance:setMeilanniSprite(arg_15_0._imageicon, arg_15_0._speicalType and "bg_tanhao" or "bg_tanhao_1")

	if arg_15_0._speicalType then
		recthelper.setAnchorX(arg_15_0._imageicon.transform, -11)
	end

	local var_15_3 = not string.nilorempty(arg_15_0._config.model)

	arg_15_0._showModel = var_15_3

	gohelper.setActive(arg_15_0._imagephoto.gameObject, var_15_3)

	if var_15_3 then
		UISpriteSetMgr.instance:setMeilanniSprite(arg_15_0._imagephoto, arg_15_0._config.model)

		local var_15_4 = string.splitToNumber(arg_15_0._config.modelPos, "#")
		local var_15_5 = var_15_4[1] or 0
		local var_15_6 = var_15_4[2] or 0

		transformhelper.setLocalPos(arg_15_0._imagephoto.transform, var_15_5, var_15_6, 0)
	end

	if not string.nilorempty(arg_15_0._config.title) then
		gohelper.setActive(arg_15_0._goinfo, true)

		arg_15_0._txttitle.text = arg_15_0._config.title
	end
end

function var_0_0._updateImage(arg_16_0)
	return
end

function var_0_0.dispose(arg_17_0)
	if not arg_17_0.viewGO.activeSelf then
		gohelper.destroy(arg_17_0.viewGO)

		return
	end

	gohelper.setActive(arg_17_0._imagephoto.gameObject, false)

	arg_17_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_17_0.viewGO)

	arg_17_0._animatorPlayer:Play("disappear", arg_17_0._disappear, arg_17_0)
end

function var_0_0._disappear(arg_18_0)
	gohelper.destroy(arg_18_0.viewGO)
end

function var_0_0.onDestroyView(arg_19_0)
	return
end

return var_0_0
