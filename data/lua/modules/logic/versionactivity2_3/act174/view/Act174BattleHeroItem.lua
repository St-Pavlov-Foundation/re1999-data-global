module("modules.logic.versionactivity2_3.act174.view.Act174BattleHeroItem", package.seeall)

local var_0_0 = class("Act174BattleHeroItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._readyItem = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	arg_2_0._goSelect = gohelper.findChild(arg_2_1, "go_Select")
	arg_2_0._goEmpty = gohelper.findChild(arg_2_1, "go_Empty")
	arg_2_0._goHero = gohelper.findChild(arg_2_1, "go_Hero")
	arg_2_0._imageRare = gohelper.findChildImage(arg_2_1, "go_Hero/rare")
	arg_2_0._heroIcon = gohelper.findChildSingleImage(arg_2_1, "go_Hero/image_Hero")
	arg_2_0._imageCareer = gohelper.findChildImage(arg_2_1, "go_Hero/image_Career")
	arg_2_0._skillIcon = gohelper.findChildSingleImage(arg_2_1, "go_Hero/skill/image_Skill")
	arg_2_0._collectionQuality = gohelper.findChildImage(arg_2_1, "go_Hero/collection/image_quality")
	arg_2_0._collectionIcon = gohelper.findChildSingleImage(arg_2_1, "go_Hero/collection/image_Collection")
	arg_2_0._collectionEmpty = gohelper.findChild(arg_2_1, "go_Hero/collection/empty")
	arg_2_0._txtIndex = gohelper.findChildText(arg_2_1, "Index/txt_Index")
	arg_2_0._goLock = gohelper.findChild(arg_2_1, "go_Lock")
	arg_2_0._btnClick = gohelper.findChildButtonWithAudio(arg_2_1, "")

	arg_2_0:addClickCb(arg_2_0._btnClick, arg_2_0.onClick, arg_2_0)

	if arg_2_0._readyItem then
		CommonDragHelper.instance:registerDragObj(arg_2_1, arg_2_0._readyItem.beginDrag, arg_2_0._readyItem.onDrag, arg_2_0._readyItem.endDrag, arg_2_0._readyItem.checkDrag, arg_2_0._readyItem, nil, true)
	end
end

function var_0_0.onClick(arg_3_0)
	if arg_3_0._readyItem and arg_3_0._readyItem.isDraging or not arg_3_0.info then
		return
	end

	local var_3_0 = arg_3_0.itemId ~= 0 and arg_3_0.itemId or nil

	Activity174Controller.instance:openRoleInfoView(arg_3_0.info.heroId, var_3_0)
end

function var_0_0.onDestroy(arg_4_0)
	arg_4_0._heroIcon:UnLoadImage()
	arg_4_0._skillIcon:UnLoadImage()
	arg_4_0._collectionIcon:UnLoadImage()

	if arg_4_0._readyItem then
		CommonDragHelper.instance:unregisterDragObj(arg_4_0._go)
	end
end

function var_0_0.setIndex(arg_5_0, arg_5_1)
	arg_5_0._txtIndex.text = arg_5_1
end

function var_0_0.setData(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.info = arg_6_1

	local var_6_0 = Activity174Model.instance:getActInfo():getGameInfo()

	if arg_6_1 then
		local var_6_1 = Activity174Config.instance:getRoleCo(arg_6_1.heroId)

		arg_6_0.itemId = arg_6_1.itemId

		if arg_6_0.itemId == 0 then
			arg_6_0.itemId = var_6_0:getTempCollectionId(arg_6_2, arg_6_1.index, arg_6_3)
		end

		local var_6_2 = lua_activity174_collection.configDict[arg_6_0.itemId]

		if var_6_1 then
			UISpriteSetMgr.instance:setAct174Sprite(arg_6_0._imageRare, "act174_ready_rolebg_" .. var_6_1.rare)
			UISpriteSetMgr.instance:setCommonSprite(arg_6_0._imageCareer, "lssx_" .. var_6_1.career)

			local var_6_3 = ResUrl.getHeadIconMiddle(var_6_1.skinId)

			arg_6_0._heroIcon:LoadImage(var_6_3)

			local var_6_4 = Activity174Config.instance:getHeroSkillIdDic(arg_6_1.heroId, true)[arg_6_1.priorSkill]
			local var_6_5 = lua_skill.configDict[var_6_4]

			if var_6_5 then
				arg_6_0._skillIcon:LoadImage(ResUrl.getSkillIcon(var_6_5.icon))
			end

			gohelper.setActive(arg_6_0._skillIcon, var_6_5)
		end

		if var_6_2 then
			arg_6_0._collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(var_6_2.icon))
			UISpriteSetMgr.instance:setAct174Sprite(arg_6_0._collectionQuality, "act174_propitembg_" .. var_6_2.rare)
		end

		gohelper.setActive(arg_6_0._collectionIcon, var_6_2)
		gohelper.setActive(arg_6_0._collectionEmpty, not var_6_2)
	end

	gohelper.setActive(arg_6_0._goHero, arg_6_1)
	gohelper.setActive(arg_6_0._goEmpty, not arg_6_1)
end

return var_0_0
