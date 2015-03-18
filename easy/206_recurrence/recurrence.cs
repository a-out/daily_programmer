/*
 * Kind of a contrived use of an Operation class and a factory,
 * but I had the pipeline pattern in mind when I wrote this.
*/

class Operation
{
	Func<int, int> _op;
	
	public Operation(Func<int, int> op)
	{
		_op = op;
	}
	
	public int Execute(int n)
	{
		return _op.Invoke(n);
	}
}

class OperationFactory
{
	public Operation Create(char op, int n)
	{
		Func<int, int> func;
		
		switch(op)
		{
			case '*':
				func = x => x * n;
				break;
			case '+':
				func = x => x + n;
				break;
			case '-':
				func = x => x - n;
				break;
			case '/':
				func = x => x / n;
				break;
			default:
				func = x => x * 0;
				break;
		}
		
		return new Operation(func);
	}
}

int GetNthItem(IEnumerable<Operation> ops, int first, int n)
{
	if (n == 0)
	{
		return first;
	}
	else
	{
		// here is where the pipeline comes in to play
		var current = ops.Aggregate(first, (x, f) => f.Execute(x));
		return GetNthItem(ops, current, n - 1);
	}
}

void Main()
{
	var input = "+2 *3 -5";
	var start = 0;
	var end = 10;
	
	var factory = new OperationFactory();
	var ops = input.Split(' ')
		.Select(s => factory.Create(s[0], Int32.Parse(s.Substring(1))));
	
	var range = Enumerable.Range(0, end + 1);
	
	foreach(var n in range)
	{
		Console.WriteLine(String.Format(
			"[{0:d2}] {1}", n, GetNthItem(ops, start, n)));
	}
}
