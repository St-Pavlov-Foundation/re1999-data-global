module("modules.logic.versionactivity2_7.act191.view.Act191HeroTipView", package.seeall)

local var_0_0 = class("Act191HeroTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")
	arg_1_0._goRoot = gohelper.findChild(arg_1_0.viewGO, "#go_Root")
	arg_1_0._goTagItem = gohelper.findChild(arg_1_0.viewGO, "#go_Root/#go_TagItem")
	arg_1_0._goSingleHero = gohelper.findChild(arg_1_0.viewGO, "#go_Root/#go_SingleHero")
	arg_1_0._goSingleTagContent = gohelper.findChild(arg_1_0.viewGO, "#go_Root/#go_SingleHero/#go_SingleTagContent")
	arg_1_0._goMultiHero = gohelper.findChild(arg_1_0.viewGO, "#go_Root/#go_MultiHero")
	arg_1_0._goMultiTagContent = gohelper.findChild(arg_1_0.viewGO, "#go_Root/#go_MultiHero/#go_MultiTagContent")
	arg_1_0._btnBuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_Root/#btn_Buy")
	arg_1_0._txtBuyCost = gohelper.findChildText(arg_1_0.viewGO, "#go_Root/#btn_Buy/#txt_BuyCost")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btnBuy:AddClickListener(arg_2_0._btnBuyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnBuy:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnBuyOnClick(arg_5_0)
	if Activity191Model.instance:getActInfo():getGameInfo().coin < arg_5_0.viewParam.cost then
		GameFacade.showToast(ToastEnum.Act174CoinNotEnough)

		return
	end

	Activity191Rpc.instance:sendBuyIn191ShopRequest(arg_5_0.actId, arg_5_0.viewParam.index, arg_5_0._buyReply, arg_5_0)
end

function var_0_0._buyReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 == 0 then
		GameFacade.showToast(arg_6_0.viewParam.toastId, arg_6_0.roleCoList[1].name)
		arg_6_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0.actId = Activity191Model.instance:getCurActId()
	arg_7_0.characterInfo = MonoHelper.addNoUpdateLuaComOnceToGo(arg_7_0._goRoot, Act191CharacterInfo)
	arg_7_0.fetterIconItemList = {}
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:refreshUI()
end

function var_0_0.onOpen(arg_9_0)
	Act191StatController.instance:onViewOpen(arg_9_0.viewName)

	if arg_9_0.viewParam.pos then
		local var_9_0 = recthelper.rectToRelativeAnchorPos(arg_9_0.viewParam.pos, arg_9_0.viewGO.transform)

		recthelper.setAnchor(arg_9_0._goRoot.transform, var_9_0.x - 100, 8)
	end

	arg_9_0:refreshUI()
end

function var_0_0.onClose(arg_10_0)
	local var_10_0 = arg_10_0.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(arg_10_0.viewName, var_10_0, arg_10_0.roleCoList[1].name)
end

function var_0_0.refreshUI(arg_11_0)
	gohelper.setActive(arg_11_0._btnClose, not arg_11_0.viewParam.notShowBg)

	if arg_11_0.viewParam.showBuy then
		arg_11_0:refreshCost()
		gohelper.setActive(arg_11_0._btnBuy, true)
	else
		gohelper.setActive(arg_11_0._btnBuy, false)
	end

	arg_11_0.heroCnt = #arg_11_0.viewParam.heroList
	arg_11_0.roleCoList = {}
	arg_11_0.roleCoList[1] = Activity191Config.instance:getRoleCo(arg_11_0.viewParam.heroList[1])

	local var_11_0 = arg_11_0.roleCoList[1]
	local var_11_1 = gohelper.findChildImage(arg_11_0._goSingleHero, "character/rare")
	local var_11_2 = gohelper.findChildSingleImage(arg_11_0._goSingleHero, "character/heroicon")
	local var_11_3 = gohelper.findChildImage(arg_11_0._goSingleHero, "character/career")
	local var_11_4 = gohelper.findChildImage(arg_11_0._goSingleHero, "image_dmgtype")
	local var_11_5 = gohelper.findChildText(arg_11_0._goSingleHero, "name/txt_name")
	local var_11_6 = Activity191Helper.getHeadIconSmall(var_11_0)

	var_11_2:LoadImage(var_11_6)
	UISpriteSetMgr.instance:setAct174Sprite(var_11_1, "act174_roleframe_" .. tostring(var_11_0.quality))
	UISpriteSetMgr.instance:setCommonSprite(var_11_3, "lssx_" .. var_11_0.career)
	UISpriteSetMgr.instance:setCommonSprite(var_11_4, "dmgtype" .. tostring(var_11_0.dmgType))

	var_11_5.text = var_11_0.name

	arg_11_0:refreshFetter(var_11_0)
	arg_11_0.characterInfo:setData(var_11_0)
	gohelper.setActive(arg_11_0._goSingleHero, true)
	gohelper.setActive(arg_11_0._goMultiHero, false)

	if false then
		arg_11_0.characterItemList = {}

		for iter_11_0 = 1, 3 do
			local var_11_7 = arg_11_0:getUserDataTb_()

			var_11_7.frame = gohelper.findChild(arg_11_0._goMultiHero, "selectframe/selectframe" .. iter_11_0)
			var_11_7.go = gohelper.findChild(arg_11_0._goMultiHero, "character" .. iter_11_0)

			local var_11_8 = arg_11_0.viewParam.heroList[iter_11_0]

			arg_11_0.roleCoList[iter_11_0] = Activity191Config.instance:getRoleCo(var_11_8)

			local var_11_9 = arg_11_0.roleCoList[iter_11_0]

			if var_11_9 then
				var_11_7.rare = gohelper.findChildImage(var_11_7.go, "rare")
				var_11_7.heroIcon = gohelper.findChildSingleImage(var_11_7.go, "heroicon")
				var_11_7.career = gohelper.findChildImage(var_11_7.go, "career")

				local var_11_10 = gohelper.findButtonWithAudio(var_11_7.go)

				arg_11_0:addClickCb(var_11_10, arg_11_0.onClickRole, arg_11_0, iter_11_0)
				UISpriteSetMgr.instance:setAct174Sprite(var_11_7.rare, "act174_roleframe_" .. tostring(var_11_9.quality))
				UISpriteSetMgr.instance:setCommonSprite(var_11_7.career, "lssx_" .. var_11_9.career)

				local var_11_11 = Activity191Helper.getHeadIconSmall(var_11_9)

				var_11_7.heroIcon:LoadImage(var_11_11)
			else
				gohelper.setActive(var_11_7.go, false)
			end

			table.insert(arg_11_0.characterItemList, var_11_7)
		end

		arg_11_0:onClickRole(1)
		gohelper.setActive(arg_11_0._goSingleHero, false)
		gohelper.setActive(arg_11_0._goMultiHero, true)
	end

	gohelper.setActive(arg_11_0._goTagItem, false)
end

function var_0_0.onClickRole(arg_12_0, arg_12_1)
	if arg_12_1 == arg_12_0.selectedIndex then
		return
	end

	local var_12_0 = arg_12_0.characterItemList[arg_12_1]
	local var_12_1 = var_12_0 and var_12_0.frame

	if not gohelper.isNil(var_12_1) then
		gohelper.setAsLastSibling(var_12_1)
	end

	arg_12_0.selectedIndex = arg_12_1

	local var_12_2 = arg_12_0.viewParam.heroList[arg_12_1]
	local var_12_3 = Activity191Config.instance:getRoleCo(var_12_2)

	arg_12_0:refreshFetter(var_12_3, true)
	arg_12_0.characterInfo:setData(var_12_3)
end

function var_0_0.refreshCost(arg_13_0)
	local var_13_0 = arg_13_0.viewParam.cost

	if var_13_0 > Activity191Model.instance:getActInfo():getGameInfo().coin then
		SLFramework.UGUI.GuiHelper.SetColor(arg_13_0._txtBuyCost, "#be4343")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_13_0._txtBuyCost, "#211f1f")
	end

	arg_13_0._txtBuyCost.text = var_13_0
end

function var_0_0.refreshFetter(arg_14_0, arg_14_1, arg_14_2)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0.fetterIconItemList) do
		gohelper.setActive(iter_14_1.go, false)
	end

	local var_14_0 = string.split(arg_14_1.tag, "#")

	for iter_14_2, iter_14_3 in ipairs(var_14_0) do
		local var_14_1 = arg_14_0.fetterIconItemList[iter_14_2]

		if not var_14_1 then
			local var_14_2 = gohelper.clone(arg_14_0._goTagItem, arg_14_0._goSingleTagContent)

			var_14_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_2, Act191FetterIconItem)
			arg_14_0.fetterIconItemList[iter_14_2] = var_14_1
		end

		var_14_1:setData(iter_14_3)
		var_14_1:setExtraParam({
			fromView = arg_14_0.viewName
		})

		if arg_14_0.viewParam.preview then
			var_14_1:setPreview()
		end

		local var_14_3 = arg_14_2 and arg_14_0._goMultiTagContent or arg_14_0._goSingleTagContent

		gohelper.addChild(var_14_3, var_14_1.go)
		gohelper.setActive(var_14_1.go, true)
	end
end

return var_0_0
