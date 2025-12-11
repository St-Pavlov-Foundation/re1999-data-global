local var_0_0 = require("modules.logic.common.defines.UIAnimationName")

module("modules.logic.handbook.view.HandbookSkinItem", package.seeall)

local var_0_1 = class("HandbookSkinItem", LuaCompBase)
local var_0_2 = {
	376,
	780
}
local var_0_3 = {
	500,
	780
}
local var_0_4 = ZProj.UIEffectsCollection
local var_0_5 = SLFramework.UGUI.GuiHelper
local var_0_6 = 0.63

function var_0_1.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._goUniqueSkin = gohelper.findChild(arg_1_0.viewGO, "#go_UniqueSkin")
	arg_1_0._goUniqueSkinsImage = gohelper.findChild(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._uniqueImageicon = gohelper.findChildImage(arg_1_0.viewGO, "#simage_icon")
	arg_1_0._goUniqueImageicon2 = gohelper.findChild(arg_1_0.viewGO, "#simage_icon2")
	arg_1_0._roleImage = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#image")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root")
	arg_1_0._uiEffectComp = var_0_4.Get(arg_1_0.viewGO)
	arg_1_0._roleImageGraphic = gohelper.findChildImage(arg_1_0.viewGO, "root/#image")
	arg_1_0._goimageL2DRole = gohelper.findChildImage(arg_1_0.viewGO, "image_L2DRole")

	arg_1_0:_addEvents()
end

function var_0_1.setData(arg_2_0, arg_2_1)
	arg_2_0._suitId = arg_2_1
end

function var_0_1.refreshItem(arg_3_0, arg_3_1)
	arg_3_0._skinId = arg_3_1
	arg_3_0.skinCfg = SkinConfig.instance:getSkinCo(arg_3_1)
	arg_3_0._skinSuitCfg = HandbookConfig.instance:getSkinSuitCfg(arg_3_0._suitId)

	local var_3_0 = arg_3_0._skinSuitCfg.spineParams

	if string.nilorempty(var_3_0) then
		-- block empty
	end

	local var_3_1 = string.split(var_3_0, "#")
	local var_3_2

	if var_3_1 then
		for iter_3_0, iter_3_1 in ipairs(var_3_1) do
			local var_3_3 = string.split(iter_3_1, "|")

			if tonumber(var_3_3[1]) == arg_3_1 then
				var_3_2 = var_3_3
			end
		end
	end

	if var_3_2 ~= nil then
		gohelper.setActive(arg_3_0._goUniqueSkinsImage, false)
		gohelper.setActive(arg_3_0._goUniqueImageicon2, false)
		gohelper.setActive(arg_3_0._roleImage.gameObject, false)
		gohelper.setActive(arg_3_0._goimageL2DRole, false)

		local var_3_4 = var_3_2[2]
		local var_3_5 = #var_3_2 > 2 and string.splitToNumber(var_3_2[3], ",") or {
			0,
			0
		}
		local var_3_6 = #var_3_2 > 3 and tonumber(var_3_2[4]) or 1

		if arg_3_0._skinSpine then
			arg_3_0._skinSpine:setResPath(var_3_4, arg_3_0._onSkinSpineLoaded, arg_3_0, true)
		else
			gohelper.setActive(arg_3_0._goUniqueSkinsImage, true)

			arg_3_0._skinSpineGO = arg_3_0._skinSpineGO or gohelper.create2d(arg_3_0._goUniqueSkinsImage, "uniqueSkinSpine")

			local var_3_7 = arg_3_0._skinSpineGO.transform

			recthelper.setWidth(var_3_7, var_0_3[1])
			transformhelper.setLocalPos(var_3_7, var_3_5[1], var_3_5[2], 0)
			transformhelper.setLocalScale(var_3_7, var_3_6, var_3_6, var_3_6)

			arg_3_0._skinSpine = GuiSpine.Create(arg_3_0._skinSpineGO, false)

			arg_3_0._skinSpine:setResPath(var_3_4, arg_3_0._onSkinSpineLoaded, arg_3_0, true)
		end
	else
		gohelper.setActive(arg_3_0._goUniqueSkinsImage, false)
		gohelper.setActive(arg_3_0._goUniqueImageicon2, false)
		arg_3_0._roleImage:LoadImage(ResUrl.getHeadIconImg(arg_3_1), arg_3_0._onLoadRoleImageDone, arg_3_0)

		arg_3_0._width = arg_3_0._roleImage.transform.parent.sizeDelta.x
	end

	local var_3_8 = HeroModel.instance:checkHasSkin(arg_3_1)

	if arg_3_0._lastHasSkin ~= var_3_8 then
		arg_3_0._lastHasSkin = var_3_8

		if var_3_8 then
			arg_3_0._uiEffectComp:SetGray(false)
		else
			arg_3_0._uiEffectComp:SetGray(true)
		end

		var_0_5.SetColor(arg_3_0._roleImageGraphic, var_3_8 and "#FFFFFF" or "#DCDCDC")
	end
end

function var_0_1._onLoadRoleImageDone(arg_4_0)
	ZProj.UGUIHelper.SetImageSize(arg_4_0._roleImage.gameObject)
end

function var_0_1.resetRes(arg_5_0)
	if arg_5_0._roleImage then
		arg_5_0._roleImage:UnLoadImage()
	end
end

function var_0_1._onSkinSpineLoaded(arg_6_0)
	local var_6_0 = arg_6_0._skinSpine:getSpineTr()
	local var_6_1 = var_6_0.parent

	recthelper.setWidth(var_6_0, recthelper.getWidth(var_6_1))
	recthelper.setHeight(var_6_0, recthelper.getHeight(var_6_1))
	arg_6_0:setSpineRaycastTarget(arg_6_0._raycastTarget)
end

function var_0_1.setSpineRaycastTarget(arg_7_0, arg_7_1)
	arg_7_0._raycastTarget = arg_7_1 == true and true or false

	if arg_7_0._skinSpine then
		local var_7_0 = arg_7_0._skinSpine:getSkeletonGraphic()

		if var_7_0 then
			var_7_0.raycastTarget = arg_7_0._raycastTarget
		end

		if not HeroModel.instance:checkHasSkin(arg_7_0._skinId) then
			var_7_0.runtimeMaterial:SetFloat(ShaderPropertyId.LumFactor, var_0_6)
		end
	end
end

function var_0_1.refreshTitle(arg_8_0)
	return
end

function var_0_1.addEventListeners(arg_9_0)
	arg_9_0._btnclick:AddClickListener(arg_9_0._btnclickOnClick, arg_9_0)
end

function var_0_1.removeEventListeners(arg_10_0)
	arg_10_0._btnclick:RemoveClickListener()
end

function var_0_1._btnclickOnClick(arg_11_0)
	local var_11_0 = arg_11_0.skinCfg.characterId
	local var_11_1 = arg_11_0.skinCfg.id
	local var_11_2 = {
		handbook = true,
		storyMode = true,
		heroId = var_11_0,
		skin = var_11_1,
		skinSuitId = arg_11_0._suitId
	}

	CharacterController.instance:openCharacterSkinView(var_11_2)
end

function var_0_1._addEvents(arg_12_0)
	return
end

function var_0_1._removeEvents(arg_13_0)
	return
end

function var_0_1.onDestroy(arg_14_0)
	arg_14_0:resetRes()
	arg_14_0:_removeEvents()
	arg_14_0:removeEventListeners()
end

return var_0_1
