module("modules.logic.versionactivity1_5.act142.view.game.Activity142GetCollectionView", package.seeall)

local var_0_0 = class("Activity142GetCollectionView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageicon = gohelper.findChildImage(arg_1_0.viewGO, "content/#go_collection/#simage_icon")
	arg_1_0._txtcollectiontitle = gohelper.findChildText(arg_1_0.viewGO, "content/#go_collection/#txt_collectiontitle")
	arg_1_0._txtcollectiondesc = gohelper.findChildText(arg_1_0.viewGO, "content/#go_collection/#txt_collectiontitle/#txt_collectiondesc")
	arg_1_0._btnclose = gohelper.getClick(arg_1_0.viewGO)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0._editableInitView(arg_3_0)
	return
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnclose:RemoveClickListener()
end

function var_0_0.onOpen(arg_5_0)
	local var_5_0 = arg_5_0.viewParam and arg_5_0.viewParam.collectionId

	if not var_5_0 then
		logError("Activity142GetCollectionView error, collectionId is nil")

		return
	end

	local var_5_1 = Activity142Model.instance:getActivityId()
	local var_5_2 = Activity142Config.instance:getCollectionCfg(var_5_1, var_5_0, true)

	if not var_5_2 then
		return
	end

	arg_5_0._txtcollectiontitle.text = var_5_2.name
	arg_5_0._txtcollectiondesc.text = var_5_2.desc

	if var_5_2.icon then
		UISpriteSetMgr.instance:setV1a5ChessSprite(arg_5_0._simageicon, var_5_2.icon)
	end

	Activity142Model.instance:setHasCollection(var_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_notebook_get)
end

function var_0_0.onClose(arg_6_0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RewardIsClose)
end

function var_0_0.onDestroyView(arg_7_0)
	return
end

return var_0_0
