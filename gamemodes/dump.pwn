#include <a_samp>
#include <core>
#include <float>

#include <Pawn.RakNet>

main()
{
	print("\n----------------------------------");
	print("  Bare Script\n");
	print("----------------------------------\n");
}

public OnPlayerConnect(playerid)
{
	GameTextForPlayer(playerid,"~w~SA-MP: ~r~Bare Script",5000,5);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new idx;
	new cmd[256];
	
	cmd = strtok(cmdtext, idx);

	if(strcmp(cmd, "/yadayada", true) == 0) {
    	return 1;
	}

	return 0;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerInterior(playerid,0);
	TogglePlayerClock(playerid,0);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
   	return 1;
}

SetupPlayerForClassSelection(playerid)
{
 	SetPlayerInterior(playerid,14);
	SetPlayerPos(playerid,258.4893,-41.4008,1002.0234);
	SetPlayerFacingAngle(playerid, 270.0);
	SetPlayerCameraPos(playerid,256.0815,-43.0475,1004.0234);
	SetPlayerCameraLookAt(playerid,258.4893,-41.4008,1002.0234);
}

public OnPlayerRequestClass(playerid, classid)
{
	SetupPlayerForClassSelection(playerid);
	return 1;
}

public OnGameModeInit()
{
	SetGameModeText("recon");
	ShowPlayerMarkers(1);
	ShowNameTags(1);
	AllowAdminTeleport(1);

	AddPlayerClass(265,1958.3783,1343.1572,15.3746,270.1425,0,0,0,0,-1,-1);

	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}

public OnIncomingPacket(playerid, packetid, BitStream:bs)
{
    printf("Incoming Packet ID: %d || %02x || PlayerID: %d", packetid, packetid, playerid);
    DumpBitStream(bs);

    return 1;
}

public OnIncomingRPC(playerid, rpcid, BitStream:bs)
{
    printf("Incoming RPC ID: %d || %02x || PlayerID: %d", rpcid, rpcid, playerid);
    DumpBitStream(bs);

    return 1;
}

public OnOutcomingPacket(playerid, packetid, BitStream:bs)
{
    printf("Outcoming Packet ID: %d || %02x || PlayerID: %d", packetid, packetid, playerid);
    DumpBitStream(bs);

    return 1;
}

public OnOutcomingRPC(playerid, rpcid, BitStream:bs)
{
    printf("Outcoming RPC ID: %d || %02x || PlayerID: %d", rpcid, rpcid, playerid);
    DumpBitStream(bs);

    return 1;
}

DumpBitStream(BitStream:bs)
{
    new bytes, loop;
    BS_GetNumberOfBytesUsed(bs, bytes);

    new buffer[3000]; //who know's how big it can get

    for(new i; i < bytes; i++)
    {
        new shit;
        BS_ReadValue(bs, PR_UINT8, shit);

        format(buffer, sizeof buffer, "%s%02x ", buffer, shit);
        loop++;

        if(loop >= 16)
        {
            strcat(buffer, "\n");
            loop = 0;
        }
    }

    strcat(buffer, "\n\n");
    print(buffer);
}