/*
 * Created by SharpDevelop.
 * User: Karl Rege
 * Date: 26.02.2021
 * Time: 16:15
 * 
 */
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Web;
using System.Net;
using System.Net.Security;
using System.Diagnostics;
using System.Threading.Tasks;
using System.Threading;
using System.Drawing;
using System.ComponentModel;

using DT2;

namespace DT3
{

    public class UrlTesterModel : INotifyPropertyChanged
    {
        public event PropertyChangedEventHandler PropertyChanged;

        int size;
        int time;
        string url;
        DT2.UrlTester urlTester;

        public UrlTesterModel()
        {
            urlTester = new DT2.UrlTester();
            IDictionary<string, Stopwatch> sw = new Dictionary<string, Stopwatch>();
            urlTester.PageStart += url => { sw.Add(url, Stopwatch.StartNew()); };
            urlTester.PageLoaded += (url, size) => {
                sw[url].Stop();
                int time = (int)sw[url].Elapsed.TotalMilliseconds;
                Size = size;
                Time = time;
                sw.Remove(url);
            };
        }

        public int Size
        {
            get { return size; }
            set
            {
                size = value;
                PropertyChanged(this, new PropertyChangedEventArgs("Size"));
            }
        }

        public int Time
        {
            get { return time; }
            set
            {
                time = value;
                PropertyChanged(this, new PropertyChangedEventArgs("Time"));
            }
        }

        public string Url
        {
            get { return url; }
            set
            {
                url = value;
                Stopwatch sw = Stopwatch.StartNew();


                Task<int> task = urlTester.GetUrlAsync(value);
                task.ContinueWith(t =>
                {
                    Size = t.Result;
                    Time = Convert.ToInt32(sw.ElapsedMilliseconds);
                });
            }
        }
    }

}