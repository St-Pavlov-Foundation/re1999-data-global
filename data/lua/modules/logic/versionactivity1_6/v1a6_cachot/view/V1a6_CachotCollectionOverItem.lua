module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionOverItem", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionOverItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagecollection = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_collection")
	arg_1_0._imageframe = gohelper.findChildImage(arg_1_0.viewGO, "#image_frame")
	arg_1_0._gogrid1 = gohelper.findChild(arg_1_0.viewGO, "layout/#go_grid1")
	arg_1_0._gonone1 = gohelper.findChild(arg_1_0.viewGO, "layout/#go_grid1/#go_none1")
	arg_1_0._goget1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "layout/#go_grid1/#go_get1")
	arg_1_0._simageicon1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "layout/#go_grid1/#go_get1/#simage_icon1")
	arg_1_0._gonone2 = gohelper.findChild(arg_1_0.viewGO, "layout/#go_grid2/#go_none2")
	arg_1_0._gogrid2 = gohelper.findChild(arg_1_0.viewGO, "layout/#go_grid2")
	arg_1_0._goget2 = gohelper.findChild(arg_1_0.viewGO, "layout/#go_grid2/#go_get2")
	arg_1_0._simageicon2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "layout/#go_grid2/#go_get2/#simage_icon2")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "#txt_dec")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

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
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnClickCachotOverItem, arg_4_0._mo.id)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(arg_7_0._mo.cfgId)

	if var_7_0 then
		arg_7_0:refreshEnchants(var_7_0)
		arg_7_0:refreshEffectDesc(var_7_0)
		UISpriteSetMgr.instance:setV1a6CachotSprite(arg_7_0._imageframe, string.format("v1a6_cachot_img_collectionframe%s", var_7_0.showRare))
		arg_7_0._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. var_7_0.icon))

		arg_7_0._txtname.text = tostring(var_7_0.name)
	end
end

var_0_0.SkillEffectDescColor = "#CAC8C5"
var_0_0.CollectionSpDescColor = "#5A8F5C"

function var_0_0.refreshEffectDesc(arg_8_0, arg_8_1)
	local var_8_0 = ""
	local var_8_1 = V1a6_CachotCollectionConfig.instance:getCollectionSkillsContent(arg_8_1)
	local var_8_2 = string.format("<%s>%s</color>", var_0_0.SkillEffectDescColor, var_8_1)
	local var_8_3 = arg_8_1 and arg_8_1.spdesc

	if not string.nilorempty(var_8_3) then
		local var_8_4 = HeroSkillModel.instance:skillDesToSpot(var_8_3)
		local var_8_5 = string.format("<%s>%s</color>", var_0_0.CollectionSpDescColor, var_8_4)

		var_8_2 = string.format("%s\n%s", var_8_2, var_8_5)
	end

	arg_8_0._txtdec.text = var_8_2
end

function var_0_0.refreshEnchants(arg_9_0, arg_9_1)
	gohelper.setActive(arg_9_0._gogrid1, arg_9_1 and arg_9_1.holeNum >= 1)
	gohelper.setActive(arg_9_0._gogrid2, arg_9_1 and arg_9_1.holeNum >= 2)

	if not arg_9_1 or not (arg_9_1.holeNum > 0) then
		return
	end

	arg_9_0:refreshSingleHole(V1a6_CachotEnum.CollectionHole.Left)
	arg_9_0:refreshSingleHole(V1a6_CachotEnum.CollectionHole.Right)
end

function var_0_0.refreshSingleHole(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._mo and arg_10_0._mo:getEnchantId(arg_10_1)

	if var_10_0 and var_10_0 ~= 0 then
		gohelper.setActive(arg_10_0["_gonone" .. arg_10_1], false)
		gohelper.setActive(arg_10_0["_goget" .. arg_10_1], true)

		local var_10_1 = V1a6_CachotModel.instance:getRogueInfo()
		local var_10_2 = var_10_1 and var_10_1:getCollectionByUid(var_10_0)
		local var_10_3 = var_10_2 and var_10_2.cfgId
		local var_10_4 = V1a6_CachotCollectionConfig.instance:getCollectionConfig(var_10_3)

		if var_10_4 then
			arg_10_0["_simageicon" .. arg_10_1]:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. var_10_4.icon))
		end
	else
		gohelper.setActive(arg_10_0["_gonone" .. arg_10_1], true)
		gohelper.setActive(arg_10_0["_goget" .. arg_10_1], false)
	end
end

function var_0_0.releaseSingleImage(arg_11_0)
	if V1a6_CachotEnum.CollectionHole then
		for iter_11_0, iter_11_1 in pairs(V1a6_CachotEnum.CollectionHole) do
			local var_11_0 = arg_11_0["_simageicon" .. iter_11_1]

			if var_11_0 then
				var_11_0:UnLoadImage()
			end
		end
	end
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simagecollection:UnLoadImage()
	arg_12_0:releaseSingleImage()
end

return var_0_0
