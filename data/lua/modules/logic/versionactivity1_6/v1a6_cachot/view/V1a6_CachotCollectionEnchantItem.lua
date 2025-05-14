module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionEnchantItem", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionEnchantItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageframe = gohelper.findChildImage(arg_1_0.viewGO, "#image_frame")
	arg_1_0._simagecollection = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_collection")
	arg_1_0._goenchant = gohelper.findChild(arg_1_0.viewGO, "#go_enchant")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_enchant/#simage_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._godescitem = gohelper.findChild(arg_1_0.viewGO, "scroll_effect/Viewport/Content/#go_descitem")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "select")
	arg_1_0._btnclick = gohelper.getClickWithDefaultAudio(arg_1_0.viewGO)
	arg_1_0._scrolleffect = gohelper.findChildScrollRect(arg_1_0.viewGO, "scroll_effect")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	V1a6_CachotCollectionEnchantController.instance:onSelectEnchantItem(arg_4_0._mo.id, true)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._goScrollContent = gohelper.findChild(arg_5_0.viewGO, "scroll_effect/Viewport/Content")
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(arg_7_0._mo.cfgId)

	if var_7_0 then
		arg_7_0._txtname.text = tostring(var_7_0.name)

		arg_7_0._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. var_7_0.icon))
		UISpriteSetMgr.instance:setV1a6CachotSprite(arg_7_0._imageframe, string.format("v1a6_cachot_img_collectionframe%s", var_7_0.showRare))
		arg_7_0:refreshCollectionUI()
		V1a6_CachotCollectionHelper.refreshSkillDesc(var_7_0, arg_7_0._goScrollContent, arg_7_0._godescitem, arg_7_0._refreshSingleSkillDesc)

		arg_7_0._scrolleffect.verticalNormalizedPosition = 1
	end
end

function var_0_0.refreshCollectionUI(arg_8_0)
	local var_8_0 = V1a6_CachotModel.instance:getRogueInfo()
	local var_8_1 = var_8_0 and var_8_0:getCollectionByUid(arg_8_0._mo.enchantUid)

	gohelper.setActive(arg_8_0._goenchant, var_8_1 ~= nil)

	if var_8_1 then
		local var_8_2 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(var_8_1.cfgId)

		if var_8_2 then
			arg_8_0._simageicon:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. var_8_2.icon))
		end
	end
end

local var_0_1 = "#C66030"
local var_0_2 = "#C66030"

function var_0_0._refreshSingleSkillDesc(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = lua_rule.configDict[arg_9_2]

	if var_9_0 then
		gohelper.findChildText(arg_9_1, "txt_desc").text = HeroSkillModel.instance:skillDesToSpot(var_9_0.desc, var_0_1, var_0_2)
	end
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goselect, arg_10_1)
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagecollection:UnLoadImage()
end

return var_0_0
