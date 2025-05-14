module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomTopRightView", package.seeall)

local var_0_0 = class("V1a6_CachotRoomTopRightView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btngroup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_group")
	arg_1_0._btncollection = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_collection")
	arg_1_0._txtcollectionnum = gohelper.findChildTextMesh(arg_1_0.viewGO, "right/#btn_collection/bg/#txt_collectionnum")
	arg_1_0._gocollectioneffect = gohelper.findChild(arg_1_0.viewGO, "right/#btn_collection/icon_effect")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngroup:AddClickListener(arg_2_0._btngroupOnClick, arg_2_0)
	arg_2_0._btncollection:AddClickListener(arg_2_0._btncollectionOnClick, arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, arg_2_0._refreshView, arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, arg_2_0.updateCollectionNum, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngroup:RemoveClickListener()
	arg_3_0._btncollection:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateRogueInfo, arg_3_0._refreshView, arg_3_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateCollectionsInfo, arg_3_0.updateCollectionNum, arg_3_0)
end

function var_0_0._btngroupOnClick(arg_4_0)
	V1a6_CachotController.instance:openV1a6_CachotTeamPreView()
end

function var_0_0._btncollectionOnClick(arg_5_0)
	V1a6_CachotController.instance:openV1a6_CachotCollectionBagView()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_refreshView()
end

function var_0_0._refreshView(arg_7_0)
	arg_7_0:updateCollectionNum()
end

function var_0_0.updateCollectionNum(arg_8_0)
	arg_8_0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	local var_8_0 = arg_8_0._rogueInfo.collections and #arg_8_0._rogueInfo.collections or 0

	arg_8_0._txtcollectionnum.text = var_8_0

	local var_8_1 = false

	if var_8_0 > 0 then
		var_8_1 = V1a6_CachotCollectionHelper.isCollectionBagCanEnchant()
	end

	gohelper.setActive(arg_8_0._gocollectioneffect, var_8_1)
end

return var_0_0
