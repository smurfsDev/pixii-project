export class Bike {
	id: string;
	SysPower: boolean;
	date: Date;
	location: {
		latitude: number,
		longitude: number,
		altitude: number,
		heading: number,
		speed: number,
		accuracy: number,
	};
	BatteryStatus: boolean;
	BatteryCap: number;
	BatteryHistory: [
		{
			value:[
				type: Date,
				type: number,
			],
			name:{ type: Date},
		}
	];
	Range: number;
	BluetoothOp: boolean;
	BluetoothCon: boolean;
	TheftState: boolean;
	SystemSOS: boolean;
	UserSOS: boolean;
	AlarmState: boolean;
	LightState: boolean;
	constructor(
		id: string,
		SysPower: boolean,
		date: Date,
		location: {
			latitude: number,
			longitude: number,
			altitude: number,
			heading: number,
			speed: number,
			accuracy: number,
		},
		BatteryStatus: boolean,
		BatteryCap: number,
		BatteryHistory: [
			{
				value:[
					type: Date,
					type: number,
				],
				name:{ type: Date},
			}
		],
		Range: number,
		BluetoothOp: boolean,
		BluetoothCon: boolean,
		TheftState: boolean,
		SystemSOS: boolean,
		UserSOS: boolean,
		ALarmState: boolean,
		LightState: boolean,
	) {
		this.id = id;
		this.SysPower = SysPower;
		this.date = date;
		this.location = location;
		this.BatteryStatus = BatteryStatus;
		this.BatteryCap = BatteryCap;
		this.BatteryHistory = BatteryHistory;
		this.Range = Range;
		this.BluetoothOp = BluetoothOp;
		this.BluetoothCon = BluetoothCon;
		this.TheftState = TheftState;
		this.SystemSOS = SystemSOS;
		this.UserSOS = UserSOS;
		this.AlarmState = ALarmState;
		this.LightState = LightState;
	}

}
