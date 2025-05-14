module("modules.logic.explore.view.ExploreMapItem", package.seeall)

local var_0_0 = class("ExploreMapItem", LuaCompBase)
local var_0_1 = typeof(UnityEngine.UI.Mask)
local var_0_2 = {
	"explore_map_img_mask7",
	"explore_map_img_mask6",
	"explore_map_img_mask8",
	"explore_map_img_mask5",
	"explore_map_img_mask3",
	"explore_map_img_mask1",
	"explore_map_img_mask4",
	"explore_map_img_mask2"
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._mo = arg_1_1
	arg_1_0._nowIconRotate = 0
	arg_1_0._isShowIcon = false
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_1:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false

	local var_2_0 = gohelper.findChild(arg_2_1, "image_left")
	local var_2_1 = gohelper.findChild(arg_2_1, "image_right")
	local var_2_2 = gohelper.findChild(arg_2_1, "image_top")
	local var_2_3 = gohelper.findChild(arg_2_1, "image_bottom")
	local var_2_4 = gohelper.findChild(arg_2_1, "typemask")

	if var_2_4 then
		arg_2_0._maskComp = var_2_4:GetComponent(var_0_1)
		arg_2_0._maskImageComp = var_2_4:GetComponent(gohelper.Type_Image)
	end

	arg_2_0._type = gohelper.findChildImage(arg_2_1, "type") or gohelper.findChildImage(arg_2_1, "typemask/type")
	arg_2_0._icon = gohelper.findChildImage(arg_2_1, "icon")
	arg_2_0._leftTrans = var_2_0.transform
	arg_2_0._rightTrans = var_2_1.transform
	arg_2_0._topTrans = var_2_2.transform
	arg_2_0._bottomTrans = var_2_3.transform

	arg_2_0:updateMo(arg_2_0._mo)
end

function var_0_0.updateMo(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0.go, true)

	arg_3_0._mo = arg_3_1

	gohelper.setActive(arg_3_0._leftTrans, arg_3_0._mo.left)
	gohelper.setActive(arg_3_0._rightTrans, arg_3_0._mo.right)
	gohelper.setActive(arg_3_0._topTrans, arg_3_0._mo.top)
	gohelper.setActive(arg_3_0._bottomTrans, arg_3_0._mo.bottom)

	if arg_3_0._maskComp then
		if arg_3_0._mo.bound then
			arg_3_0._maskComp.enabled = true
			arg_3_0._maskImageComp.enabled = true

			local var_3_0 = var_0_2[arg_3_0._mo.bound]

			UISpriteSetMgr.instance:setExploreSprite(arg_3_0._maskImageComp, var_3_0)
		else
			arg_3_0._maskComp.enabled = false
			arg_3_0._maskImageComp.enabled = false
		end
	end

	transformhelper.setLocalPosXY(arg_3_0.go.transform, arg_3_0._mo.posX, arg_3_0._mo.posY)

	local var_3_1 = ExploreMapModel.instance:getNode(arg_3_0._mo.key)

	if var_3_1 then
		UISpriteSetMgr.instance:setExploreSprite(arg_3_0._type, "dungeon_secretroom_landbg_" .. var_3_1.nodeType)
	end

	arg_3_0:updateOutLineIcon()

	if arg_3_0._mo.rotate then
		arg_3_0:updateRotate()
	end
end

function var_0_0.updateRotate(arg_4_0)
	if not arg_4_0._isShowIcon or not arg_4_0._mo.rotate or arg_4_0._nowIconRotate == ExploreMapModel.instance.nowMapRotate then
		return
	end

	arg_4_0._nowIconRotate = ExploreMapModel.instance.nowMapRotate

	transformhelper.setLocalRotation(arg_4_0._icon.transform, 0, 0, -ExploreMapModel.instance.nowMapRotate)
end

local var_0_3 = Color.clear
local var_0_4 = Color.white

function var_0_0.updateOutLineIcon(arg_5_0)
	local var_5_0 = not arg_5_0._mo.bound and ExploreMapModel.instance:getSmallMapIcon(arg_5_0._mo.key)

	if var_5_0 then
		UISpriteSetMgr.instance:setExploreSprite(arg_5_0._icon, var_5_0)

		arg_5_0._icon.color = var_0_4
		arg_5_0._isShowIcon = true
	else
		arg_5_0._icon.color = var_0_3
		arg_5_0._isShowIcon = false
	end
end

function var_0_0.setActive(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0.go, arg_6_1)
end

function var_0_0.markUse(arg_7_0, arg_7_1)
	arg_7_0._isUse = arg_7_1
end

function var_0_0.getIsUse(arg_8_0)
	return arg_8_0._isUse
end

function var_0_0.setScale(arg_9_0, arg_9_1)
	if arg_9_0._mo.left then
		transformhelper.setLocalScale(arg_9_0._leftTrans, arg_9_1, 1, 1)
	end

	if arg_9_0._mo.right then
		transformhelper.setLocalScale(arg_9_0._rightTrans, arg_9_1, 1, 1)
	end

	if arg_9_0._mo.top then
		transformhelper.setLocalScale(arg_9_0._topTrans, arg_9_1, 1, 1)
	end

	if arg_9_0._mo.bottom then
		transformhelper.setLocalScale(arg_9_0._bottomTrans, arg_9_1, 1, 1)
	end
end

return var_0_0
