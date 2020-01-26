class StockRow extends React.Component {
    render() {
        let dollarStyle = `align-right ${this.props.style}`;
      return (
        <React.Fragment>
            <td className={this.props.style}>{this.props.symbol}</td> 
            <td className={this.props.style}>{this.props.change}</td>
            <td>{this.props.quantity}</td>
            <td className={dollarStyle}>${this.props.value}</td>
        </React.Fragment>
        )
    }
  }